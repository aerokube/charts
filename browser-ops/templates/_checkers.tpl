{{- define "check.tagformat" }}
{{- if regexMatch "^short$" .Values.browserImageTagFormat }}
{{- else }}
{{- if regexMatch "^long$" .Values.browserImageTagFormat }}
{{- else }}
{{- fail (printf "wrong browserImageTagFormat value %s: must be \"short\" or \"long\"" .Values.browserImageTagFormat) }}
{{- end }}
{{- end }}
{{- end }}

{{- define "check.taglist" }}
{{- if regexMatch "^\"all\"$" (.Values.browserImageVersions | quote) }}
{{- else }}
{{- if regexMatch "^\"recent\"$" (.Values.browserImageVersions | quote)}}
{{- else }}
{{- if regexMatch "^\"[1-9][0-9]*\"$" (.Values.browserImageVersions | quote) }}
{{- else }}
{{- fail (printf "wrong browserImageVersions value %s: must be \"all\", \"recent\" or positive number" (.Values.browserImageVersions | quote))}}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
