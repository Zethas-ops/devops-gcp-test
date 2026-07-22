variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "region" {
  description = "Deployment Region"
  type        = string
  default     = "asia-southeast2"
}

variable "zone" {
  description = "Deployment Zone"
  type        = string
  default     = "asia-southeast2-a"
}

variable "database_password" {
  description = "Password for Cloud SQL application user"
  type        = string
  sensitive   = true
}

variable "db_tier" {
  description = "Cloud SQL instance tier"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_size" {
  description = "Cloud SQL instance disk size in GB"
  type        = number
  default     = 10
}

variable "instance_name" {
  description = "Cloud SQL instance name"
  type        = string
  default     = "devops-postgres"
}

variable "database_name" {
  description = "Cloud SQL database name"
  type        = string
  default     = "appdb"
}

variable "database_user" {
  description = "Cloud SQL database user"
  type        = string
  default     = "appuser"
}

variable "repository_id" {
  description = "Artifact Registry repository ID"
  type        = string
  default     = "devops-docker-repo"
}

variable "repository_format" {
  description = "Artifact Registry repository format"
  type        = string
  default     = "DOCKER"
}

variable "repository_description" {
  description = "Artifact Registry repository description"
  type        = string
  default     = "Docker repository for devops images"
}

variable "cloudrun_service_name" {
  description = "Cloud Run service name"
  type        = string
  default     = "devops-cloudrun-service"
}

variable "cloudrun_image" {
  description = "Docker image URL for Cloud Run service"
  type        = string
}

variable "cloudrun_port" {
  description = "Port for the application inside the container"
  type        = number
  default     = 8080
}

variable "service_account_email" {
  type        = string
  description = "Cloud Run Service Account"
}

variable "alert_email" {
  description = "Email used for Cloud Monitoring alerts"
  type        = string
}