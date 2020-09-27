{{/* Create kubernetes deployment object */}}

{{- define "common.deployment" }}
{{- if .enabled }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .name | quote }}
spec:
{{- if not .hpa.enabled }}
  replicas: {{ .replicaCount }}
{{- end }}
  selector:
    matchLabels:
      app: {{ .name | quote }}
  template:
    metadata:
      annotations:
        rollme: {{ randAlphaNum 5 | quote }}
        {{- range $key, $val := .annotations }}
        {{ $key }}: {{ $val | quote }}
        {{- end }}
      labels:
        app: {{ .name | quote }}
    spec:
      affinity:
        {{- toYaml .affinity | nindent 8 }}
      volumes:
        {{- toYaml .volumes | nindent 8 }}
      containers:
        - name: {{ .name | quote }}
          image: >-
            {{ required "repo" .image.repository }}:{{ required "tag" .image.tag }}
          imagePullPolicy: {{ .image.pullPolicy | quote }}
          ports:
            {{- toYaml .ports | nindent 12 }}
          resources:
            {{- toYaml .resources | nindent 12 }}
          envFrom:
          {{- toYaml .envFrom | nindent 10 }}
          {{- range .env }}
          - configMapRef:
              name: {{ .name }}
          {{- end }}
          volumeMounts:
            {{- toYaml .volumeMounts | nindent 12 }}
          {{- if .command }}
          command:
            {{- toYaml .command | nindent 12 }}
          {{- else }}
          command: [bash, -c, "trap : TERM INT; sleep infinity & wait"]
          {{- end }}
      imagePullSecrets:
        {{- toYaml .imagePullSecrets | nindent 8 }}
      nodeSelector:
        {{- toYaml .nodeSelector | nindent 8 }}
---
{{- end }}
{{- end }}
