terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

resource "google_container_cluster" "primary" {
  name     = "cat-gifs-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # For regional clusters, use node_locations to specify the zones
  node_locations = [
    "us-central1-a",
    "us-central1-f",
  ]
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "cat-gifs-node-pool"
  cluster  = google_container_cluster.primary.name
  location = var.region

  initial_node_count = 1

  node_config {
    machine_type  = var.machine_type
    disk_size_gb  = var.disk_size_gb
    disk_type     = var.disk_type
    image_type    = "UBUNTU_CONTAINERD"
    oauth_scopes  = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  lifecycle {
    ignore_changes = [
      node_config[0].kubelet_config,
      node_config[0].resource_labels,
      node_config[0].tags,
    ]
  }
}
