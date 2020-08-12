{{/* Generate cloudvolume secret volumes */}}
{{- define "chunkedgraph-segmentation.volumes" }}
      volumes:
      {{- range $path, $_ := .Files.Glob printf "%s/*" trimSuffix "/" (required "cloudvolume secrets dir" .Values.cloudvolumeSecretsPath) }}
      {{- $fname := $path | base }}
      {{- $name := $path | base | regexFind "^([^.]+)" }}
        - name: {{ $name | quote }}
          secret:
            secretName: {{ $fname | quote }}
      {{- end }}
{{- end }}


{{/* Generate cloudvolume secret volume mounts */}}
{{- define "chunkedgraph-segmentation.volume-mounts" }}
          volumeMounts:
          {{- range $path, $_ := .Files.Glob printf "%s/*" trimSuffix "/" (required "cloudvolume secrets dir" .Values.cloudvolumeSecretsPath) }}
          {{- $fname := $path | base }}
          {{- $name := $path | base | regexFind "^([^.]+)" }}
            - name: {{ $name | quote }}
              mountPath: /root/.cloudvolume/secrets/{{ $fname }}
              subPath: {{ $fname | quote }}
              readOnly: true
          {{- end }}
{{- end }}