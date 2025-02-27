module "uptime-check-calculation" {
  source  = "terraform-google-modules/cloud-operations/google//modules/simple-uptime-check"
  version = "0.6.0"

  for_each = var.calculation_uptime_targets

  uptime_check_display_name = each.value
  project_id                = var.project_id

  timeout      = "60s"
  period       = "600s"
  protocol     = "HTTPS"
  validate_ssl = true

  path = each.key

  monitored_resource = {
    monitored_resource_type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "calculate.geneticscores.org"
    }
  }

  content = "{\"status\":\"UP\",\"groups\":[\"liveness\",\"readiness\"]}"
  matcher = "CONTAINS_STRING"

  accepted_response_status_classes = ["STATUS_CLASS_2XX"]

  existing_notification_channels = values(google_monitoring_notification_channel.notification_channel)[*].id

  # number of failures to trigger the alert
  condition_threshold_value = 3
}

