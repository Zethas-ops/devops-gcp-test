output "instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.postgres.name
}

output "connection_name" {
  description = "Cloud SQL connection name"
  value       = google_sql_database_instance.postgres.connection_name
}

output "private_ip" {
  description = "Private IP address of the Cloud SQL instance"
  value       = google_sql_database_instance.postgres.private_ip_address
}

output "database_name" {
  description = "Name of the Cloud SQL database"
  value       = google_sql_database.database.name
}

output "public_ip_address" {
  description = "Public IP of Cloud SQL instance"
  value       = google_sql_database_instance.postgres.public_ip_address
}