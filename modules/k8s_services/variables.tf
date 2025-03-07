variable "project_id" {
  description = "The GCP project to deploy the infrastructure"
  type        = string
  nullable    = false
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "autopilot_endpoint" {
  type = string
}

variable "autopilot_ca_certificate" {
  type = string
}

variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  type = map(object({
    roles               = list(string)
    namespace           = string
    use_existing_k8s_sa = optional(bool, false)
  }))
}