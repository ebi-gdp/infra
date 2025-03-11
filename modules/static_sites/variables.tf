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

variable "static_ip_id" {
  description = "Static IP address identifier for the resource with format projects/{{project}}/global/addresses/{{name}}"
  type        = string
}