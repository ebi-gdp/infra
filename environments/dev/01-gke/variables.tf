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
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Allowed values for input_parameter are \"dev\", \"test\", or \"prod\"."
  }
}
