output "notification_channel" {
  description = "Created notification channel"
  value       = module.k8s_services.notification_channel
}