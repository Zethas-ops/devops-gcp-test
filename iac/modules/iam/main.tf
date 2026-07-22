resource "google_service_account" "cloudrun" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = var.display_name
}

resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id

  role = "roles/cloudsql.client"

  member = "serviceAccount:${google_service_account.cloudrun.email}"
}