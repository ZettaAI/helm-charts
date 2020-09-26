{{/*Create common labels for metadata.*/}}

{{- define "common.labels-standard" -}}
app: {{ .Chart.Name }}-{{ .Release.Name }}
chart: {{ .Chart.Name }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}


{{/*Prefix name with chart name for disambiguation.*/}}

{{- define "common.prefix-chart-name" -}}
  {{ .Chart.Name }}-{{ . }}-{{ randAlphaNum 5 | lower }}
{{- end -}}