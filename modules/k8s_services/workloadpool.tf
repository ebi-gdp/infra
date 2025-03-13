resource "google_iam_workload_identity_pool" "gitlab" {
  workload_identity_pool_id = "gitlab-pool"
  display_name              = "EBI GitLab"
  description               = "Identity pool for CI/CD"
}

resource "google_iam_workload_identity_pool_provider" "gitlab-provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.gitlab.workload_identity_pool_id
  workload_identity_pool_provider_id = "gitlab-provider"

  display_name = "EBI GitLab"
  description  = "OIDC provider for EBI GitLab"

  oidc {
    issuer_uri = "https://gitlab.ebi.ac.uk"
  }

  attribute_mapping = {
    "google.subject"              = "assertion.sub"
    "attribute.gitlab_project_id" = "assertion.project_id"
  }
}

// important for GitLab pipelines to read from GCP secret manager
resource "google_secret_manager_secret_iam_binding" "gitlab_secret_access" {
  for_each  = toset(var.gitlab_project_ids)
  secret_id = google_secret_manager_secret.db-secret.id
  role      = "roles/secretmanager.secretAccessor"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gitlab.name}/attribute.gitlab_project_id/${each.value}"
  ]
}
