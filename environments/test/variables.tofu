variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The region for the GCP resources"
  default     = "europe-west2"
  type        = string

  validation {
    condition     = contains(["europe-west2"], var.environment)
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