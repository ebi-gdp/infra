/*
* This files create a new vpc and subnets different to the default ones
* https://gitlab.ebi.ac.uk/wap-public/ebi-iac/infrastructure-stacks/-/blob/63b70ba8389eb177fecab2579604e7a6059f651f/terraform/gcp/light-data-presentation-stack/modules/presentation-stack/vpc.tf
*/

module "network_vpc" {
  source       = "terraform-google-modules/network/google//modules/vpc"
  version      = "10.0.0"
  project_id   = var.project_id
  network_name = local.network_name
  routing_mode = "REGIONAL"
}

module "network_subnets" {
  source           = "terraform-google-modules/network/google//modules/subnets"
  version          = "10.0.0"
  project_id       = var.project_id
  network_name     = module.network_vpc.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
