resource "google_monitoring_notification_channel" "email" {
  project      = var.project_id
  display_name = "Email Notification"
  type         = "email"

  labels = {
    email_address = var.alert_email
  }
}

resource "google_monitoring_uptime_check_config" "cloudrun_healthcheck" {
  project      = var.project_id
  display_name = "Cloud Run Health Check"

  timeout = "10s"
  period  = "60s"

  http_check {
    path    = "/healthz"
    port    = 443
    use_ssl = true
  }

  monitored_resource {
    type = "uptime_url"

    labels = {
      host = replace(var.service_url, "https://", "")
    }
  }
}

resource "google_monitoring_alert_policy" "cloudrun_alert" {
  project      = var.project_id
  display_name = "Cloud Run Health Alert"

  combiner = "OR"

  conditions {
    display_name = "Health Check Failed"

    condition_threshold {

      filter = <<EOF
metric.type="monitoring.googleapis.com/uptime_check/check_passed"
resource.type="uptime_url"
EOF

      comparison      = "COMPARISON_LT"
      threshold_value = 1
      duration        = "300s"

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.email.id
  ]
}