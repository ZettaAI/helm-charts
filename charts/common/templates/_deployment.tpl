{{/* Create kubernetes deployment object */}}

{{- define "common.deployment" }}
{{- if .deployment.enabled }}
{{- $deploymentName := .deployment.name }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .deployment.name | quote }}
  labels:
{{ include "common.labels-standard" . | indent 4 -}}
spec:
{{- if not .deployment.hpa.enabled }}
  replicas: {{ .deployment.replicaCount }}
{{- end }}
  selector:
    matchLabels:
      app: {{ .deployment.name | quote }}
  template:
    metadata:
      annotations:
        rollme: {{ randAlphaNum 5 | quote }}
        {{- range $key, $val := .deployment.annotations }}
        {{ $key }}: {{ $val | quote }}
        {{- end }}
      labels:
        app: {{ .deployment.name | quote }}
    spec:
      affinity:
        {{- toYaml .deployment.affinity | nindent 8 }}
      volumes:
        {{- toYaml .deployment.volumes | nindent 8 }}
      containers:
        - name: {{ .deployment.name | quote }}
          image: >-
            {{ required "repo" .deployment.image.repository }}:{{ required "tag" .deployment.image.tag }}
          imagePullPolicy: {{ .deployment.image.pullPolicy | quote }}
          ports:
            {{- toYaml .deployment.ports | nindent 12 }}
          resources:
            {{- toYaml .deployment.resources | nindent 12 }}
          envFrom:
          {{- range .deployment.env }}
          - configMapRef:
              name: {{ printf "%s-%s" $deploymentName .name }}
          {{- end }}
          volumeMounts:
            {{- toYaml .deployment.volumeMounts | nindent 12 }}
          {{- if .deployment.command }}
          command:
            {{- toYaml .deployment.command | nindent 12 }}
          {{- else }}
          command: [bash, -c, "trap : TERM INT; sleep infinity & wait"]
          {{- end }}
      imagePullSecrets:
        {{- toYaml .deployment.imagePullSecrets | nindent 8 }}
      nodeSelector:
        {{- toYaml .deployment.nodeSelector | nindent 8 }}
---
{{- end }}
{{- end }}
