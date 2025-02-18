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

# Create a GKE cluster without the default node pool.
resource "google_container_cluster" "primary" {
  name     = "cat-gifs-cluster"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"

  # Disable basic auth to encourage using secure credentials
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Create a custom node pool using Ubuntu images.
resource "google_container_node_pool" "primary_nodes" {
  name       = "cat-gifs-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.region

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    # Specify Ubuntu as the node image type.
    image_type = "UBUNTU"
  }

  initial_node_count = 1
}
