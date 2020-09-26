{{/* Create kubernetes service account object */}}

{{- define "common.service" }}
{{- if .create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .name }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
---
{{- end }}
{{- end }}
