resource "google_service_account" "nextflow" {
  account_id   = "nextflow"
  display_name = "Nextflow service account"
}

resource "google_project_iam_member" "nextflow-roles" {
  // https://seqera.io/blog/nextflow-with-gbatch/
  for_each = toset([
    "roles/batch.jobsEditor",
    "roles/iam.serviceAccountUser",
    "roles/logging.viewer",
    "roles/storage.admin"
  ])

  role    = each.key
  project = var.project_id
  member  = "serviceAccount:${google_service_account.nextflow.email}"
}

resource "google_project_service" "services" {
  for_each = toset([
    "compute.googleapis.com",
    "logging.googleapis.com",
    "batch.googleapis.com"
  ])
  service = each.key
  project = var.project_id
}
