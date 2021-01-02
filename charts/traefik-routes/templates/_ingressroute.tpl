{{/*
Generate Traefik IngressRoute
https://docs.traefik.io/routing/providers/kubernetes-crd/
*/}}

{{- define "traefik.ingressroute" }}
{{ $rel := .Release }}
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: {{ .name }}-{{ $rel }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  entryPoints:
    {{- toYaml .entryPoints | nindent 4 }}
  routes:
  {{- range .rules }}
  - kind: {{ .kind }}
    match: {{ .match }}
    services:
    {{- toYaml .services | nindent 4 }}
    middlewares:
    {{- range .middlewares }}
    - name: {{ .name }}-{{ $rel }}
    {{- end }}
  {{- end }}
  {{- if .tls }}
  tls:
    {{- toYaml .tls | nindent 4 }}
  {{- end }}
---
{{- end }}