output "load_balancer_id" {
  description = "The id of the created load balancer"
  value       = google_compute_global_address.static_lb_ip.id
}