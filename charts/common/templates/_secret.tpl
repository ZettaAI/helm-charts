{{/* Create kubernetes secret object */}}

{{- define "common.secret-from-files" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}
type: Opaque
data:
  {{- range $key, $val := .files }}
  {{ $key }}: |-
    {{ $val | b64enc }}
  {{- end }}
---
{{ end -}}