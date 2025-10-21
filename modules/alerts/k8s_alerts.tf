resource "google_logging_metric" "k8s_error_logging_metric" {
  for_each = var.logging_metrics
  name   = "custom/${each.key}-error-metric"
  filter = each.value.filter
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_monitoring_alert_policy" "k8s_error_alert_policy" {
  display_name = "Kubernetes workloads error Policy"
  combiner     = "OR"
  dynamic "conditions" {
    for_each = google_logging_metric.k8s_error_logging_metric
    content {
      display_name = "Error Alert for ${conditions.key} namespace"
      condition_threshold {
        filter     = "metric.type=\"logging.googleapis.com/user/${conditions.value["id"]}\" AND resource.type=\"k8s_container\""
        duration   = "60s"
        comparison = "COMPARISON_GT"
      }
    }
  }
  notification_channels = [ var.notification_channel ]
}