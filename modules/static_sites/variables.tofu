variable "project_id" {
  description = "The GCP project to deploy the infrastructure"
  nullable    = false
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "static_buckets" {
  description = "Map subdomain to bucket prefixes (static sites)"
  type        = map(string)
  default = {
    "docs.geneticscores.org"    = "geneticscores-org-docs"
    "methods.geneticscores.org" = "geneticscores-org-methods"
    "geneticscores.org"         = "geneticscores-org"
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}