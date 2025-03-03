/*
* Allowing outbound connection from the cluster to the internet
* https://gitlab.ebi.ac.uk/wap-public/ebi-iac/infrastructure-stacks/-/blob/63b70ba8389eb177fecab2579604e7a6059f651f/terraform/gcp/light-data-presentation-stack/modules/presentation-stack/nat.tf
*/

resource "google_compute_router" "main_router" {
  project = var.project_id
  name    = "${var.environment}-nat-router"
  network = module.network_vpc.network_name
  region  = var.region
}

module "cloud-nat" {
  source                             = "terraform-google-modules/cloud-nat/google"
  version                            = "5.3"
  project_id                         = var.project_id
  region                             = var.region
  router                             = google_compute_router.main_router.name
  name                               = "${var.environment}-nat-config"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
