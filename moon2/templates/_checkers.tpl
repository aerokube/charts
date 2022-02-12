{{/*
    At least one quota must be configured.
*/}}
{{- define "check.quota" }}
{{- if not .Values.quota }}
{{- fail "at least one quota must be configured: quota is empty" }}
{{- end }}
{{- end }}

{{/*
    Namespaces must be set for all quota
*/}}
{{- define "check.quota.namespaces" }}
{{- range $name, $quota := .Values.quota }}
{{- if not $quota }}
{{- fail (printf "namespace must be set quota: quota.%s.namespace is not set" $name) }}
{{- end }}
{{- if not $quota.namespace }}
{{- fail (printf "namespace must be set quota: quota.%s.namespace is not set" $name) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
    At least one config object must be configured.
*/}}
{{- define "check.configs" }}
{{- if not .Values.configs }}
{{- fail "at least one config must be configured: configs is empty" }}
{{- end -}}
{{- end }}

{{/*
    In case more than one config object specified all quota.*.config fields must be set
*/}}
{{- define "check.quota.configs" }}
{{- range $name, $quota := .Values.quota }}
{{- if not $quota.config }}
{{- fail (printf "there is no default config but quota.%s.config is empty" $name) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
    At least one browsers object must be configured.
*/}}
{{- define "check.browsers" }}
{{- if not .Values.browsers }}
{{- fail "at least one browsers object must be configured: browsers is empty" }}
{{- end -}}
{{- end }}

{{/*
    In case more than one browsers object specified all quota.*.browsers fields must be set
*/}}
{{- define "check.quota.browsers" }}
{{- range $name, $quota := .Values.quota }}
{{- if not $quota.browsers }}
{{- fail (printf "there is no default browsers but quota.%s.browsers is empty" $name) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
    Ingress cannot work without host
*/}}
{{- define "check.ingress.host" }}
{{- if not .Values.ingress.host }}
{{- fail "ingress.host must be set" }}
{{- end }}
{{- end }}
