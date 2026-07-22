variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "instance_name" {
  type    = string
  default = "devops-postgres"
}

variable "database_name" {
  type    = string
  default = "appdb"
}

variable "database_user" {
  type    = string
  default = "appuser"
}

variable "database_password" {
  type      = string
  sensitive = true
}

variable "db_tier" {
  type    = string
  default = "db-f1-micro"
}

variable "disk_size" {
  type    = number
  default = 10
}