// https://seqera.io/blog/nextflow-with-gbatch/
resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "logging.googleapis.com",
    "batch.googleapis.com"
  ])
  service = each.key
  project = var.project_id

  disable_on_destroy = false
}
