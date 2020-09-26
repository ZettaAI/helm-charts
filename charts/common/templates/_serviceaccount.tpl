{{/* Create kubernetes service account object */}}

{{- define "common.service" }}
{{- if .serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .serviceAccount.name }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
  annotations:
    {{- toYaml .serviceAccount.annotations | nindent 4 }}
---
{{- end }}
{{- end }}
