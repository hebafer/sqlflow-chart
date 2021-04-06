{{/*
Expand the name of the chart.
*/}}
{{- define "sqlflow.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sqlflow.fullname" -}}
{{- if .Values.sqlflowserver.fullnameOverride }}
{{- .Values.sqlflowserver.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.sqlflowserver.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sqlflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sqlflow.labels" -}}
helm.sh/chart: {{ include "sqlflow.chart" . }}
{{ include "sqlflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sqlflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sqlflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sqlflow.serviceAccountName" -}}
{{- if .Values.serviceAccounts.default.create }}
{{- default .Values.serviceAccounts.default.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.default.name }}
{{- end }}
{{- end }}
{{/*
Create a service account to be used by the SQLFlow Server
*/}}
{{- define "sqlflowserver.serviceAccountName" -}}
{{- if .Values.serviceAccounts.sqlflowserver.create }}
{{- default .Values.serviceAccounts.sqlflowserver.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.sqlflowserver.name }}
{{- end }}
{{- end }}
{{/*
Create a service account to be used by the SQLFlow Jupyterhub
*/}}
{{- define "jupyterhub.serviceAccountName" -}}
{{- if .Values.serviceAccounts.jupyterhub.create }}
{{- default .Values.serviceAccounts.jupyterhub.name }}
{{- else }}
{{- default "default" .Values.serviceAccounts.jupyterhub.name }}
{{- end }}
{{- end }}