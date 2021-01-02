{{/*
Generate Traefik IngressRoute
https://docs.traefik.io/routing/providers/kubernetes-crd/
*/}}
{{- define "traefik.ingressroute" }}
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: {{ .name }}-{{ .Release.Name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  entryPoints:
    {{- toYaml .entryPoints | nindent 4 }}
  routes:
    {{- toYaml .rules | nindent 4 }}
  {{- if .tls }}
  tls:
    {{- toYaml .tls | nindent 4 }}
  {{- end }}
---
{{- end }}