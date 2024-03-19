
variable "project_id" {
  description = "The GCP project to deploy resources"
}

variable "environment" {
  description = "The environment to deploy resources"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
}

# variable "jeager_url" {
#   description = "The URL of the Jaeger instance"
# }

# variable "prometheus_url" {
#   description = "The URL of the Prometheus instance"
# }

# variable "grafana_url" {
#   description = "The URL of the Grafana instance"
# }

# variable "alertmanager_url" {
#   description = "The URL of the Alertmanager instance"
# }

variable "applications_gateway" {
  description = "The name of the Istio gateway to use for the applications"
}

variable "istio_gateway_namespace" {
  description = "The namespace of the Istio gateway"
}


variable "dns_name" {
  description = "The DNS name of the cluster"
}
