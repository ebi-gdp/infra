/*
If you are creating additional user for the databases
we recommend to set the variable random_password to true.
The generated password will be stored in a GCP secret
*/

resource "google_project_service" "enable_secrets_manager" {
  project            = var.project_id
  service            = "secretmanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_secret_manager_secret" "secrets" {
  // transform a flat list of objects into a map for the for_each block
  // the key of the map is definitely nonsensitive
  for_each = { for obj in nonsensitive(local.db_users) : obj.name => obj }

  secret_id = each.key

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  depends_on = [google_project_service.enable_secrets_manager]
}

resource "google_secret_manager_secret_version" "secrets" {
  for_each = { for obj in nonsensitive(local.db_users) : obj.name => obj }

  secret      = google_secret_manager_secret.secrets[each.key].id
  secret_data = each.value.secret_data
}
