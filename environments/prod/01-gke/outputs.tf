output "gke_cluster_endpoint" {
  value = module.autopilot.endpoint
}

output "gke_cluster_ca_certificate" {
  value     = module.autopilot.ca_certificate
  sensitive = true
}