{{/* Create kubernetes service object */}}

{{- define "common.service" }}
{{- if .service.enabled }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .service.name | quote }}
  annotations:
    {{- toYaml .service.annotations | nindent 4 }}
spec:
  selector:
    app: {{ .target | quote }}
  type: {{ .service.type }}
  ports:
    {{- toYaml .service.ports | nindent 4 }}
---
{{- end }}
{{- end }}