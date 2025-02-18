output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "The endpoint (IP address) of the GKE cluster master."
  value       = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  description = "The Base64 encoded public certificate that is the root of trust for the cluster."
  value       = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
