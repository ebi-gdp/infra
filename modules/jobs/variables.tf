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
