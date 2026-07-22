resource "google_project_service" "required_services" {
  for_each = toset([
    "compute.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "artifactregistry.googleapis.com",
    "vpcaccess.googleapis.com",
    "secretmanager.googleapis.com",
    "servicenetworking.googleapis.com",
  ])

  project = var.project_id
  service = each.key

  disable_on_destroy = false
}

module "network" {
  source = "./modules/network"

  project_id = var.project_id
  region     = var.region
}

module "cloudsql" {
  source = "./modules/cloudsql"

  project_id = var.project_id
  region     = var.region

  instance_name     = var.instance_name
  database_name     = var.database_name
  database_user     = var.database_user
  database_password = var.database_password

  db_tier   = var.db_tier
  disk_size = var.disk_size

  depends_on = [
    module.network,
    google_project_service.required_services
  ]
}

module "artifact_registry" {
  source = "./modules/artifact_registry"

  region        = var.region
  repository_id = var.repository_id
  format        = var.repository_format
  description   = var.repository_description

  depends_on = [
    google_project_service.required_services
  ]
}

module "cloudrun" {
  source = "./modules/cloudrun"

  service_name = var.cloudrun_service_name
  region       = var.region
  image        = var.cloudrun_image
  port         = var.cloudrun_port

  service_account_email = module.iam.email

  cloud_sql_connection_name = module.cloudsql.connection_name

  env_vars = {
    DB_HOST     = "/cloudsql/${module.cloudsql.connection_name}"
    DB_NAME     = var.database_name
    DB_USER     = var.database_user
    DB_PASSWORD = var.database_password
    DB_PORT     = "5432"
  }

  allow_unauthenticated = true

  depends_on = [
    module.cloudsql,
    module.artifact_registry
  ]
}

module "monitoring" {
  source = "./modules/monitoring"

  project_id = var.project_id

  service_url = module.cloudrun.service_url

  alert_email = var.alert_email

  depends_on = [
    module.cloudrun,
    google_project_service.required_services
  ]
}

module "iam" {
  source = "./modules/iam"

  project_id = var.project_id

  service_account_id = "cloudrun-sa"

  display_name = "Cloud Run Service Account"

  depends_on = [
    google_project_service.required_services
  ]
}