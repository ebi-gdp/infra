// create secrets in secret manager which are kubernetes manifests for secret objects

resource "google_secret_manager_secret" "db-secret" {
  secret_id = "database-secret"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "db-secret" {
  secret      = google_secret_manager_secret.db-secret.id
  secret_data = local.db_manifest
}
