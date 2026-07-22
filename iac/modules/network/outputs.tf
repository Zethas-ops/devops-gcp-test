output "network_id" {
  value = google_compute_network.vpc.id
}

output "network_name" {
  value = google_compute_network.vpc.name
}

output "private_subnet" {
  value = google_compute_subnetwork.private.id
}

output "public_subnet" {
  value = google_compute_subnetwork.public.id
}