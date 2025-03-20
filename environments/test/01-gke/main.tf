
/*
module "static-sites" {
  source       = "../../../modules/static_sites"
  environment  = var.environment
  static_ip_id = data.google_compute_global_address.static_site_lb_ip.id
}
*/

/*
module "alerts" {
  source         = "../../../modules/alerts"
  project_id     = var.project_id
  alert_contacts = var.alert_contacts
  environment    = "test"
}
*/

// https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips#cluster_sizing_secondary_range_pods
// maximum cluster size: 64 autopilot pods
module "autopilot" {
  source      = "../../../modules/k8s/"
  project_id  = var.project_id
  environment = var.environment
  secondary_ranges = {
    test-main-subnet = [{
      range_name    = "test-gke-pods-subnet",
      ip_cidr_range = "10.10.2.0/23"
      },
      {
        range_name    = "test-gke-svcs-subnet",
        ip_cidr_range = "10.10.4.0/24"
    }]
  }
  subnets = [{
    subnet_name           = "test-main-subnet",
    subnet_ip             = "10.10.0.0/23",
    subnet_region         = "europe-west2",
    subnet_private_access = "true",
    description           = "Main subnet"
  }]
  databases = {
    "intervene-${var.environment}" = {
      deletion_protection_enabled = false
      private_address             = "10.10.0.25",
      additional_users = [{
        name            = "intervene-${var.environment}",
        password        = null,
        random_password = true
      }]
    }
  }
  use_sql_proxy = true
}
