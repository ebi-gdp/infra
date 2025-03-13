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

variable "db_secret" {
  description = "Username/password for CloudSQL database"
  type = object({
    DB_USERNAME = string
    DB_PASSWORD = string
  })
  sensitive = true
}

variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  type = map(object({
    roles               = list(string)
    namespace           = string
    use_existing_k8s_sa = optional(bool, false)
  }))
}

variable "gitlab_project_ids" {
  description = "GitLab project IDs which have CI/CD pipelines that need to read from GCP secret manager"
  default     = ["4766", "4654"]
  type        = list(string)
}