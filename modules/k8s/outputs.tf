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