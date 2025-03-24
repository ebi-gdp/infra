data "terraform_remote_state" "services" {
  backend = "gcs"

  config = {
    bucket = "genetic-scores-tofu-state"
    prefix = "prod-services"
  }
}

module "alerts" {
  source               = "../../../modules/alerts"
  project_id           = var.project_id
  notification_channel = data.terraform_remote_state.services.outputs.notification_channel
}

module "static-sites" {
  source    = "../../../modules/static_sites"
  static_ip = data.google_compute_global_address.static_site_lb_ip
}