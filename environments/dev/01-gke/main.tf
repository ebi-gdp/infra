// https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#cluster_sizing_secondary_range_pods
module "autopilot" {
  source      = "../../../modules/k8s/"
  project_id  = var.project_id
  environment = var.environment
  secondary_ranges = {
    prod-main-subnet = [{
      range_name    = "${var.environment}-gke-pods-subnet",
      ip_cidr_range = "10.11.0.0/16"
      },
      {
        range_name    = "${var.environment}-gke-svcs-subnet",
        ip_cidr_range = "10.12.0.0/20"
    }]
  }
  subnets = [{
    subnet_name           = "${var.environment}-main-subnet",
    subnet_ip             = "10.10.0.0/16",
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
        enabled = false
      }
      instance_type               = "db-f1-micro"
      deletion_protection_enabled = false
    }
  }
  use_sql_proxy               = true
  cluster_deletion_protection = false
}