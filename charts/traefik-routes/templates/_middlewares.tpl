{{/*
Generate various Traefik Middlewares
https://docs.traefik.io/middlewares/overview/
*/}}
{{- define "traefik.headerMiddleware" }}
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  headers:
    {{- toYaml .headers | nindent 4 }}
---
{{- end }}


{{- define "traefik.redirectMiddleware" }}
apiVersion: "traefik.containo.us/v1alpha1"
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  redirectScheme:
    {{- toYaml .redirectScheme | nindent 4 }}
---
{{- end }}


{{- define "traefik.basicAuthMiddleware" }}
apiVersion: "traefik.containo.us/v1alpha1"
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  basicAuth:
    {{- toYaml .basicAuth | nindent 4 }}
---
{{- end }}


{{- define "traefik.stripPrefixMiddleware" }}
apiVersion: "traefik.containo.us/v1alpha1"
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  stripPrefix:
    {{- toYaml .stripPrefix | nindent 4 }}
---
{{- end }}


{{- define "traefik.chainMiddleware" }}
apiVersion: "traefik.containo.us/v1alpha1"
kind: Middleware
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default "default" | quote }}
spec:
  chain:
    middlewares:
    {{- range .middlewares }}
    - name: {{ . | quote }}
    {{- end }}
---
{{- end }}