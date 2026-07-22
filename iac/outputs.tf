output "cloud_run_url" {
  value = module.cloudrun.service_url
}

output "artifact_registry_url" {
  value = module.artifact_registry.repository_url
}

output "cloudsql_connection_name" {
  value = module.cloudsql.connection_name
}

output "uptime_check_name" {
  value = module.monitoring.uptime_check_name
}

output "notification_channel" {
  value = module.monitoring.notification_channel
}

output "alert_policy_name" {
  value = module.monitoring.alert_policy_name
}