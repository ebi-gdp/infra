output "notification_channel" {
  description = "Created notification channel"
  value       = google_monitoring_notification_channel.default.id
}