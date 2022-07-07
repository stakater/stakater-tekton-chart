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
  {{- if eq .taskName $task_to_search.taskName }}
  {{ $result := set $result "params" .params }}
  {{ $result := set $result "workspaces" .workspaces }}
  {{ $result := set $result "name" .name }}
  {{ $result := set $result "when" .when }}
  {{ $result := set $result "runAfter" .runAfter }}
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
  {{- $default_task_list := index . 1 }}
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
  {{ $result | toJson }}
{{- end }}
