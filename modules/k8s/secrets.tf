/*
If you are creating additional user for the databases
we recommend to set the variable random_password to true.
The generated password will be stored in a GCP secret
*/

resource "google_project_service" "enable_secrets_manager" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

module "db_users_password" {
  // transform a flat list of objects into a map for the for_each block
  // the key of the map is definitely nonsensitive
  for_each = { for obj in nonsensitive(local.db_users) : obj.name => obj }

  source     = "GoogleCloudPlatform/secret-manager/google"
  version    = "0.7"
  project_id = var.project_id

  // the key is an object with the attributes automatic_replication, name, and secret_data
  secrets = [{ "name" : each.value.name, secret_data = each.value.secret_data }]

  depends_on = [google_project_service.enable_secrets_manager]
}