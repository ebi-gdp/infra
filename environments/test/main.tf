module "static-sites" {
  source       = "../../modules/static_sites"
  environment  = var.environment
  static_ip_id = data.google_compute_global_address.static_site_lb_ip.id
}

module "uptime_checks" {
  source         = "../../modules/uptime_checks"
  project_id     = var.project_id
  alert_contacts = var.alert_contacts
}


module "autopilot" {
  source      = "../../modules/k8s/"
  project_id  = var.project_id
  environment = var.environment
  secondary_ranges = {
    test-main-subnet = [{
      range_name    = "test-gke-pods-subnet",
      ip_cidr_range = "10.10.2.0/24"
      },
      {
        range_name    = "test-gke-svcs-subnet",
        ip_cidr_range = "10.10.3.0/24"
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
}

module "k8s_services" {
  source                   = "../../modules/k8s_services/"
  project_id               = var.project_id
  environment              = var.environment
  autopilot_ca_certificate = module.autopilot.ca_certificate
  autopilot_endpoint       = module.autopilot.endpoint
  oidc_service_accounts    = var.oidc_service_accounts
  db_secret = {
    DB_USERNAME = "intervene-${var.environment}"
    DB_PASSWORD = module.autopilot.db_password
  }
}