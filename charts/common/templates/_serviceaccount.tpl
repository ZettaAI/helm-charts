{{/* Create kubernetes service account object */}}

{{- define "common.service" }}
{{- if .create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .name }}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
---
{{- end }}
{{- end }}
