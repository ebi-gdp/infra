module "static-sites" {
  source     = "../../modules/static_sites"
  project_id = var.project_id
}

module "uptime_checks" {
  source     = "../../modules/uptime_checks"
  project_id = var.project_id
  alert_contacts = var.alert_contacts
}