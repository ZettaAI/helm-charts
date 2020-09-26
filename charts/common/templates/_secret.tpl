{{/* Create kubernetes secret object */}}

{{- define "common.secret-from-files" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .secret.name }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
type: Opaque
data:
  {{- range $key, $val := .secret.files }}
  {{ $key }}: |-
    {{ $val | b64enc }}
  {{- end }}
---
{{ end -}}