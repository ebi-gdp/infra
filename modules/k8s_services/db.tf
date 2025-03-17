// enables cloud sql admin API for cloud-auth-proxy

resource "google_project_service" "dbservices" {
  for_each = toset([
    "sqladmin.googleapis.com"
  ])
  service = each.key
  project = var.project_id

  disable_on_destroy = false
}
