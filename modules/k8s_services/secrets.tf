// create secrets in secret manager which are kubernetes manifests for secret objects

resource "google_secret_manager_secret" "secrets" {
  for_each = local.secrets

  secret_id = each.key

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "secrets" {
  for_each = local.secrets

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value
}
