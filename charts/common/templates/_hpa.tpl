{{/* Create kubernetes hpa object */}}

{{- define "common.hpa" }}
{{- if and .deployment.enabled .deployment.hpa.enabled }}
apiVersion: autoscaling/v2beta1
kind: HorizontalPodAutoscaler
metadata:
  name: {{ .deployment.name | quote }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
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
