{{/* Create kubernetes service object */}}

{{- define "common.service" }}
{{- if .service.enabled }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .service.name | quote }}
  namespace: {{ .namespace | default "default" | quote }}
  annotations:
    {{- toYaml .service.annotations | nindent 4 }}
  labels:
    {{- range $key, $val := .service.labels }}
    {{ $key }}: {{ $val | quote }}
    {{- end }}
spec:
  selector:
    app: {{ .target | quote }}
  type: {{ .service.type }}
  {{- if .service.loadBalancerIP }}
  loadBalancerIP: {{ .service.loadBalancerIP }}
  {{- end }}
  ports:
    {{- toYaml .service.ports | nindent 4 }}
---
{{- end }}
{{- end }}