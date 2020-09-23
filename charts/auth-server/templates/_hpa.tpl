{{/* Generate hpa from .Values.<service> */}}
{{- define "auth-server.hpa" }}
{{- if and .deployment.enabled .deployment.hpa.enabled }}
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .deployment.name | quote }}
  labels:
    app: {{ .Chart.Name | quote }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ .deployment.name | quote }}
  minReplicas: {{ .deployment.hpa.minReplicas }}
  maxReplicas: {{ .deployment.hpa.maxReplicas }}
  metrics:
  {{- if .deployment.hpa.targetCPU }}
    - type: Resource
      resource:
        name: cpu
        targetAverageUtilization: {{ .deployment.hpa.targetCPU }}
  {{- end }}
  {{- if .deployment.hpa.targetMem }}
    - type: Resource
      resource:
        name: memory
        targetAverageUtilization: {{ .deployment.hpa.targetMem }}
  {{- end }}
---
{{- end }}
{{- end }}
