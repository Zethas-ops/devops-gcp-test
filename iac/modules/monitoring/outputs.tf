output "uptime_check_name" {
  value = google_monitoring_uptime_check_config.cloudrun_healthcheck.display_name
}

output "notification_channel" {
  value = google_monitoring_notification_channel.email.display_name
}

output "alert_policy_name" {
  value = google_monitoring_alert_policy.cloudrun_alert.display_name
}