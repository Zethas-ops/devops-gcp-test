variable "service_name" {
  type        = string
  description = "Nama service Cloud Run"
}

variable "region" {
  type = string
}

variable "image" {
  type        = string
  description = "URL image Docker di Artifact Registry / Container Registry"
}

variable "cloud_sql_connection_name" {
  type        = string
  description = "Connection name dari Cloud SQL instance (contoh: project:region:instance)"
  default     = ""
}

variable "env_vars" {
  type        = map(string)
  description = "Key-value pair untuk Environment Variables (DB_HOST, DB_NAME, dll.)"
  default     = {}
}

variable "port" {
  type        = number
  description = "Port aplikasi di dalam container"
  default     = 8080
}

variable "allow_unauthenticated" {
  type        = bool
  description = "Apakah service dapat diakses publik tanpa autentikasi"
  default     = true
}

variable "service_account_email" {
  type        = string
  description = "Service Account yang digunakan Cloud Run"
}