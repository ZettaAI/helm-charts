{{/* Generate common configmaps from env groups */}}
{{- define "auth-server.configmaps" }}
{{- $prefix := .prefix }}
{{- range .env }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ printf "%s-%s" $prefix .name }}
data:
  {{- range $key, $val := .vars }}
  {{ $key }}: {{ $val | quote }}
  {{- end }}
---
{{- end}}
{{- end }}
