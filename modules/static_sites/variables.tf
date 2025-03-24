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

variable "static_ip" {
  description = "Name of static ip used for kubernetes ingress"
  type = object({
    address : string,
    address_type : string,
    id : string,
    name : string,
    network : string,
    network_tier : string,
    prefix_length : number,
    project : string,
    purpose : string,
    self_link : string,
    status : string,
    subnetwork : string,
    users : string,
  })
}
