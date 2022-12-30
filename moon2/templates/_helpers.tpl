{{/*
    Basic authorization on Openshift
*/}}
{{- define "basic.auth" -}}
{{- $httpAuth := true -}}
{{- if eq (len .Values.quota) 1 -}}
  {{- $httpAuth = false -}}
  {{- range $name, $quota := .Values.quota -}}
    {{- if not $quota.password -}}
      {{- if empty (printf "%s" $quota.password) -}}
        {{- $httpAuth = true -}}
      {{- end -}}
    {{- else -}}
      {{- $httpAuth = true -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- if $httpAuth -}}
  {{- if .Values.ingress.enabled -}}
    {{- if .Values.ingress.openshift -}}
openshift
    {{- else -}}
kubernetes
    {{- end -}}
  {{- else -}}
moon-basic-auth
  {{- end -}}
{{- end -}}
{{- end -}}
