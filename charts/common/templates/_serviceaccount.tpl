{{/* Create kubernetes service account object */}}

{{- define "common.service" }}
{{- if .create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
  annotations:
    {{- toYaml .annotations | nindent 4 }}
  labels:
    {{- range $key, $val := .labels }}
    {{ $key }}: {{ $val | quote }}
    {{- end }}
---
{{- end }}
{{- end }}
