{{/*
Expand the name of the chart.
*/}}
{{- define "pipeline-charts.name" -}}
{{- default .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "pipeline-charts.get_default_task_values" }}
  {{- $givenTaskSpec := index . 0 }}
  {{- $defaultTaskSpec := index . 1 }}
  {{- $defaultTaskSpec :=  dict }}
  {{- range $defaultTaskSpec }}
  {{- if eq .taskName $givenTaskSpec.taskName }}
  {{ $defaultTaskSpec := set $defaultTaskSpec "params" .params }}
  {{ $defaultTaskSpec := set $defaultTaskSpec "workspaces" .workspaces }}
  {{ $defaultTaskSpec := set $defaultTaskSpec "runAfter" .runAfter }}
  {{- end }}
  {{- end }}
  {{- $defaultTaskSpec | toJson }}
{{- end }}