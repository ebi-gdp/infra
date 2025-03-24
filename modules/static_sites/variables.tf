variable "region" {
  type    = string
  default = "europe-west2"
}

variable "static_buckets" {
  description = "Map subdomain to bucket prefixes (static sites)"
  type        = map(string)
  default = {
    "docs.geneticscores.org"    = "geneticscores-org-docs-backend"
    "methods.geneticscores.org" = "geneticscores-org-methods-backend"
    "geneticscores.org"         = "geneticscores-org-backend"
  }
}

variable "static_ip_name" {
  type        = string
  description = "Name of static ip used for kubernetes ingress"
}
