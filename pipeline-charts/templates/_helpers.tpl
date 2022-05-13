{{/*
Expand the name of the chart.
*/}}
{{- define "pipeline-charts.name" -}}
{{- default .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pipeline-charts.get_default_task_values" }}
  {{- $arg1 := index . 0 }}
  {{- $arg2 := index . 1 }}
  {{- $result :=  dict }}
  {{- range $arg2 }}
  {{- if eq .taskName $arg1.taskName }}
  {{ $result := set $result "params" .params }}
  {{ $result := set $result "workspaces" .workspaces }}
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
  {{- if eq .triggerName $arg1.triggerName }}
  {{ $result := set $result "interceptors_cel_filter" .interceptors_cel_filter }}
  {{ $result := set $result "interceptors_cel_overlays" .interceptors_cel_overlays }}
  {{- end }}
  {{- end }}
  {{- $result | toJson }}
{{- end }}