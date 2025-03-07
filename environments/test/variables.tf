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

variable "alert_contacts" {
  description = "Alert contacts (format: email = description)"
  type        = map(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "test"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Allowed values for input_parameter are \"dev\", \"test\", or \"prod\"."
  }
}

variable "oidc_service_accounts" {
  description = "service account in the GKE cluster to use GCP services"
  default = {
    "hattivatti" = {
      namespace           = "intervene-test",
      use_existing_k8s_sa = false,
    roles = ["roles/storage.admin"] },
    "nextflow" = {
      namespace           = "intervene-test",
      use_existing_k8s_sa = false,
      roles = [
        "roles/batch.jobsEditor",
        "roles/iam.serviceAccountUser",
        "roles/logging.viewer",
      "roles/storage.admin"]
    }
    "gcp-service-api" = {
      namespace           = "intervene-test",
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
    roles               = list(string)
    namespace           = string
    use_existing_k8s_sa = optional(bool, true)
  }))
}