{{/*
Return the chart name.
*/}}
{{- define "helmchart.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{/*
Create a default fully qualified name.
*/}}
{{- define "helmchart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Helper to return the MySQL service name.
*/}}
{{- define "helmchart.mysqlService" -}}
{{ include "helmchart.fullname" . }}-mysql-service
{{- end -}}
