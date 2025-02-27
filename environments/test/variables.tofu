variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The region for the GCP resources"
  default     = "europe-west2"
  type        = string
}

variable "alert_contacts" {
  description = "Alert contacts (format: email = description)"
  type        = map(string)
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "test"
}