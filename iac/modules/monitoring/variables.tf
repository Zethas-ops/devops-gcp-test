variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "service_url" {
  description = "Cloud Run Service URL"
  type        = string
}

variable "alert_email" {
  description = "Email address for monitoring alerts"
  type        = string
}