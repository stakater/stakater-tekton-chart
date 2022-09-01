{{/*
Expand the name of the chart.
*/}}
{{- define "pipeline-charts.name" -}}
{{- default .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pipeline-charts.get_default_task_values" }}
  {{- $task_to_search := index . 0 }}
  {{- $default_tasks := index . 1 }}
  {{- $result :=  dict }}
  {{- range $default_tasks }}
  {{- if eq .name ( $task_to_search.default_config_task_name ) }}
  {{ $result := set $result "params" .params }}
  {{ $result := set $result "workspaces" .workspaces }}
  {{ $result := set $result "name" .name }}
  {{ $result := set $result "when" .when }}
  {{ $result := set $result "runAfter" .runAfter }}
  {{ $result := set $result "taskSpec" .taskSpec }}
  {{ $result := set $result "taskRef" .taskRef }}  
  {{- end }}
  {{- end }}
  {{- $result | toJson }}
{{- end }}

{{- define "pipeline-charts.get_event_listener_default_trigger" }}
  {{- $arg1 := index . 0 }}
  {{- $arg2 := index . 1 }}
  {{- $result :=  dict }}
  {{- range $arg2 }}
  {{- if eq .triggerName $arg1 }}
  {{ $result := set $result "interceptors" .interceptors }}
  {{ $result := set $result "bindings" .bindings }}
  {{- end }}
  {{- end }}
  {{- $result | toJson }}
{{- end }}

{{- define "pipeline-charts.get_pipeline_params" }}
  {{- $task_list := index . 0 }}
  {{- $finally_task_list := index . 1}}
  {{- $default_task_list := index . 2 }}
  {{- $result :=  dict }}
  {{- range $task_list }}
    {{- $default_task := include "pipeline-charts.get_default_task_values" (list . $default_task_list ) | fromJson }}
    {{- range .params }}
      {{- if .value }}
      {{- $match := regexFindAll "\\$\\(params\\.[a-zA-Z0-9\\-_]+\\)" .value -1 }}
      {{- range $match }}
      {{ $p := . | replace "$(params." "" | replace ")" ""}}
      {{- $result = set $result $p "" }}
      {{- end }}
      {{- else }}
      {{- $result = set $result .name "" }}
      {{- end }}
    {{- end }}
    {{- range $default_task.params }}
      {{- if .value }}
      {{- $match := regexFindAll "\\$\\(params\\.[a-zA-Z0-9\\-_]+\\)" .value -1 }}
      {{- range $match }}
      {{ $p := . | replace "$(params." "" | replace ")" ""}}
      {{- $result = set $result $p "" }}
      {{- end }}
      {{- else }}
      {{- $result = set $result .name "" }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- range $finally_task_list }}
  {{- $default_task := include "pipeline-charts.get_default_task_values" (list . $default_task_list ) | fromJson }}
  {{- range .params }}
    {{- if .value }}
    {{- $match := regexFindAll "\\$\\(params\\.[a-zA-Z0-9\\-_]+\\)" .value -1 }}
    {{- range $match }}
    {{ $p := . | replace "$(params." "" | replace ")" ""}}
    {{- $result = set $result $p "" }}
    {{- end }}
    {{- else }}
    {{- $result = set $result .name "" }}
    {{- end }}
  {{- end }}
  {{- range $default_task.params }}
    {{- if .value }}
    {{- $match := regexFindAll "\\$\\(params\\.[a-zA-Z0-9\\-_]+\\)" .value -1 }}
    {{- range $match }}
    {{ $p := . | replace "$(params." "" | replace ")" ""}}
    {{- $result = set $result $p "" }}
    {{- end }}
    {{- else }}
    {{- $result = set $result .name "" }}
    {{- end }}
  {{- end }}
{{- end }}
  {{ $result | toJson }}
{{- end }}

{{- define "pipeline-charts.merge_params" }}
  {{- $list1 := index . 0 }}
  {{- $list2 := index . 1}}
  {{- $name_only := index . 2 }}
  {{- $result:= list }}
  {{- if or $list1 $list2 }}
      {{- $addedParams := dict }}
      {{- range $list2 }}
      {{- $addedParams := set $addedParams .name "e" }}
        {{- if $name_only }}
        {{- $result = (dict "name" .name ) | append $result  }}
        {{- else }}
        {{- if .value }}
        {{- $result = (dict "name" .name "value" .value) | append $result  }}
        {{- else }}
        {{- $v := printf "$(params.%s)" .name }}
        {{- $result = (dict "name" .name "value" $v) | append $result }}
        {{- end }}
        {{- end }}
      {{- end }}
      {{- range $list1 }}
      {{- if hasKey $addedParams .name }}
      {{- else }}
        {{- if $name_only }}
        {{- $result = (dict "name" .name ) | append $result  }}
        {{- else }}
        {{- if .value }}
        {{- $result = (dict "name" .name "value" .value) | append $result }}
        {{- else }}
        {{- $v := printf "$(params.%s)" .name }}
        {{- $result = (dict "name" .name "value" $v) | append $result }}
        {{- end }}
        {{- end }}
      {{- end }}
      {{- end }}
  {{- end }}
  {{- $result | toYaml }}
{{- end }}

{{- define "pipeline-charts.merge_workspaces" }}
  {{- $list1 := index . 0 }}   
  {{- $list2 := index . 1 }}
  {{- $name_only := index . 2 }}
  {{- $result:= list }}
  {{- if or $list1 $list2 }}
      {{- $addedParams := dict }}
      {{- range $list2 }}
      {{- $addedParams := set $addedParams .name "e" }}
      {{- if $name_only }}
      {{- $result = (dict "name" .name ) | append $result  }}
      {{- else }}
      {{- $result = (dict "name" .name "workspace" .workspace) | append $result }}
      {{- end }}
      {{- end }}
      {{- range $list1 }}
      {{- if hasKey $addedParams .name }}
      {{- else }}
      {{- if $name_only }}
      {{- $result = (dict "name" .name ) | append $result  }}
      {{- else }}
      {{- $result = (dict "name" .name "workspace" .workspace) | append $result }}
      {{- end }}
      {{- end }}
      {{- end }}
  {{- end }}
  {{- $result | toYaml }}
{{- end }}
