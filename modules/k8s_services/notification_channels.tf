resource "google_monitoring_notification_channel" "default" {
  display_name = "Email Notification: GDP developers"
  type         = "email"
  labels = {
    email_address = var.alert_contact
  }
}
