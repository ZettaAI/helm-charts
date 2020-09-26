{{/* Create kubernetes configmap object from env list */}}

{{- define "common.configmap-from-env" }}
{{- range . }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .name }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
data:
  {{- range $key, $val := .vars }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
---
{{- end}}
{{- end }}
