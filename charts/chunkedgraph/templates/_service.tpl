{{/* Generate service from .Values.<service> */}}
{{- define "cg.service" }}
{{- if .service.enabled }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .service.name | quote }}
  annotations:
    {{- toYaml .service.annotations | nindent 4 }}
  labels:
    app: {{ .Chart.Name | quote }}
spec:
  selector:
    app: {{ .target | quote }}
  type: {{ .service.type }}
  ports:
    - port: {{ .service.port }}
      protocol: {{ .service.protocol | quote }}
      name: {{ .service.portName | quote }}
      targetPort: {{ .service.targetPort }}
---
{{- end }}
{{- end }}