resource "google_monitoring_alert_policy" "server_exception_alert" {
  display_name = "${var.environment} environment server exception"
  enabled      = true
  combiner     = "OR"

  conditions {
    display_name = "Log match condition"

    condition_matched_log {
      filter = <<-EOT
        resource.labels.namespace_name="intervene-${var.environment}"
        textPayload=~".*ServerException.*"
      EOT
    }
  }

  alert_strategy {
    notification_rate_limit {
      period = "900s" # 15 minutes
    }
    auto_close           = "1800s" # 30 minutes auto-close duration
    notification_prompts = ["OPENED"]
  }

  severity = "CRITICAL"

  notification_channels = [for channel in google_monitoring_notification_channel.notification_channel : channel.id]
}