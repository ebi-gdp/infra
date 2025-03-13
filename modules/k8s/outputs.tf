output "network_id" {
  description = "The ID of the created VPC network."
  value       = module.network_vpc.network_id
}

output "ca_certificate" {
  description = "GKE autopilot CA certificate"
  value       = module.gke_autopilot.ca_certificate
}

output "endpoint" {
  description = "GKE autopilot cluster endpoint"
  value       = module.gke_autopilot.endpoint
}

data "google_secret_manager_secret_version" "db_password" {
  // database name is cloudsql-${db_name}-${var.environment}
  // TODO: this won't play nicely with multiple users but we only have one
  secret     = "cloudsql-intervene-${var.environment}-intervene-${var.environment}"
  depends_on = [module.db_users_password]
}

output "db_password" {
  value     = data.google_secret_manager_secret_version.db_password.secret_data
  sensitive = true
}