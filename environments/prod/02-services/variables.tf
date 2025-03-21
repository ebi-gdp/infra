
variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The region for the GCP resources"
  default     = "europe-west2"
  type        = string

  validation {
    condition     = contains(["europe-west2"], var.region)
    error_message = "Infrastructure must be ddeployed to europe-west2 region"
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"

  validation {
    condition     = contains(["prod"], var.environment)
    error_message = "Environment must be prod"
  }
}

variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  default = {
    "hattivatti" = {
      namespace                       = "intervene-prod",
      use_existing_k8s_sa             = false,
      automount_service_account_token = true,
    roles = ["roles/storage.admin"] },
    "nextflow" = {
      namespace           = "intervene-prod",
      use_existing_k8s_sa = false,
      roles = [
        "roles/batch.jobsEditor",
        "roles/iam.serviceAccountUser",
        "roles/logging.viewer",
      "roles/storage.admin"]
    }
    "gcp-service-api" = {
      namespace           = "intervene-prod",
      use_existing_k8s_sa = false
      roles = [
        "roles/cloudsql.client",
        "roles/cloudsql.instanceUser",
        "roles/secretmanager.admin",
        "roles/storage.admin"
      ]
    }
  }
  type = map(object({
    roles                           = list(string)
    namespace                       = string
    use_existing_k8s_sa             = optional(bool, true)
    automount_service_account_token = optional(bool, false)
  }))
}

variable "basic_auth_secret" {
  description = "Configuration for microservices using basic access authentication"
  type = object({
    BASIC_AUTH_USERNAME = string
    BASIC_AUTH_PASSWORD = string
    SEC_KEY_PASSWORD    = string
  })
  sensitive = true
}

variable "email_secret" {
  description = "Configuration for email notifications"
  type = object({
    INTERVENE_EMAIL_ID       = string
    INTERVENE_EMAIL_PASSWORD = string
  })
  sensitive = true
}

variable "globus_secret" {
  description = "Configuration for globus authentication"
  type = object({
    GLOBUS_CLIENT_ID     = string
    GLOBUS_CLIENT_SECRET = string
  })
  sensitive = true
}
