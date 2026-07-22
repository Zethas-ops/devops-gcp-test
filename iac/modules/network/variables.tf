variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type    = string
  default = "devops-vpc"
}

variable "public_subnet_name" {
  type    = string
  default = "public-subnet"
}

variable "private_subnet_name" {
  type    = string
  default = "private-subnet"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.10.2.0/24"
}