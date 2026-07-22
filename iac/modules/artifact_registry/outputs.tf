output "repository_id" {
  value       = google_artifact_registry_repository.docker.repository_id
  description = "ID dari Artifact Registry repository yang dibuat"
}

output "repository_name" {
  value       = google_artifact_registry_repository.docker.name
  description = "Nama lengkap resource Artifact Registry (fully qualified name)"
}

output "repository_url" {
  value = "${var.region}-docker.pkg.dev/${google_artifact_registry_repository.docker.project}/${google_artifact_registry_repository.docker.repository_id}"

  description = "Docker Artifact Registry URL"
}

output "repository_location" {
  value = google_artifact_registry_repository.docker.location
}

output "repository_format" {
  value = google_artifact_registry_repository.docker.format
}