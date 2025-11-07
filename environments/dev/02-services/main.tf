data "google_secret_manager_secret_version" "cloudsql" {
  secret = local.db_secret_name
}

data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "genetic-scores-tofu-state"
    prefix = "dev-gke"
  }
}

module "k8s_services" {
  source                   = "../../../modules/k8s_services/"
  project_id               = var.project_id
  environment              = var.environment
  autopilot_ca_certificate = data.terraform_remote_state.gke.outputs.gke_cluster_ca_certificate
  autopilot_endpoint       = data.terraform_remote_state.gke.outputs.gke_cluster_endpoint
  oidc_service_accounts    = var.oidc_service_accounts
  db_secret = {
    DB_USERNAME = local.db_username
    DB_PASSWORD = data.google_secret_manager_secret_version.cloudsql.secret_data
  }
  basic_auth_secret = local.basic_auth_secret
  email_secret      = var.email_secret
  globus_secret     = var.globus_secret
  static_ip_name    = data.google_compute_global_address.calculation_service_lb_ip.name
  gitlab_runner_config = {
    gitlab_url = "https://gitlab.ebi.ac.uk/"
    
  }
  gitlab_runner_token = var.gitlab_runner_token
}
