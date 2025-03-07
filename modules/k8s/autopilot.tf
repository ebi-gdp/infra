terraform {
  required_version = ">= 1.0.0, < 2.0.0"
}

/*
* GKE Cluster.
*/

module "gke_autopilot" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-autopilot-private-cluster"
  version                    = "36.0.0"
  project_id                 = var.project_id
  name                       = "${var.environment}-gke-autopilot"
  region                     = var.region
  zones                      = var.default_azs
  network                    = module.network_vpc.network_name
  subnetwork                 = "${var.environment}-main-subnet"
  ip_range_pods              = "${var.environment}-gke-pods-subnet"
  ip_range_services          = "${var.environment}-gke-svcs-subnet"
  horizontal_pod_autoscaling = var.horizontal_pod_autoscaling
  grant_registry_access      = var.grant_registry_access
  enable_private_nodes       = var.enable_private_nodes
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  // replace this for true or remove it
  deletion_protection = var.cluster_deletion_protection
  depends_on          = [module.network_vpc, module.network_subnets]
}



