// https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#cluster_sizing_secondary_range_pods
// maximum cluster size: 64 autopilot pods
module "autopilot" {
  source      = "../../../modules/k8s/"
  project_id  = var.project_id
  environment = var.environment
  secondary_ranges = {
    prod-main-subnet = [{
      range_name    = "${var.environment}-gke-pods-subnet",
      ip_cidr_range = "10.10.2.0/23"
      },
      {
        range_name    = "${var.environment}-gke-svcs-subnet",
        ip_cidr_range = "10.10.4.0/24"
    }]
  }
  subnets = [{
    subnet_name           = "${var.environment}-main-subnet",
    subnet_ip             = "10.10.0.0/23",
    subnet_region         = "europe-west2",
    subnet_private_access = "true",
    description           = "Main subnet"
  }]
  databases = {
    "intervene-${var.environment}" = {
      private_address = "10.10.0.25",
      additional_users = [{
        name            = "intervene-${var.environment}",
        password        = null,
        random_password = true
      }]
      backup_configuration = {
        location = var.region
      }
      // 1 vCPU, ~4GB RAM
      instance_type               = "db-custom-1-3840"
      deletion_protection_enabled = true
    }
  }
  use_sql_proxy               = true
  cluster_deletion_protection = true
}
