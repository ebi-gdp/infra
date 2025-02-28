resource "google_monitoring_notification_channel" "notification_channel" {
  for_each = var.alert_contacts

  display_name = "Email Notification - ${each.value}"
  type         = "email"
  labels = {
    email_address = each.key
  }
}
