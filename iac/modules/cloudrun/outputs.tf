output "service_url" {
  value       = google_cloud_run_v2_service.default.uri
  description = "URL publik untuk mengakses Cloud Run service"
}

output "service_name" {
  value       = google_cloud_run_v2_service.default.name
  description = "Nama dari Cloud Run service"
}

output "region" {
  value       = google_cloud_run_v2_service.default.location
  description = "Region Cloud Run service"
}