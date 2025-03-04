resource "google_service_account" "hattivatti" {
  account_id   = "hattivatti"
  display_name = "Job submitter service account"
}

resource "google_project_iam_member" "hattivatti-roles" {
  role    = "roles/storage.admin"
  project = var.project_id
  member  = "serviceAccount:${google_service_account.hattivatti.email}"
}