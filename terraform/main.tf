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

  # Set the master version explicitly so we can reference it in the node pool.
  master_version = var.master_version
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "cat-gifs-node-pool"
  cluster  = google_container_cluster.primary.name
  location = var.region

  initial_node_count = 1

  # Set node_version explicitly using the cluster's master_version.
  node_version = google_container_cluster.primary.master_version

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    image_type   = "UBUNTU_CONTAINERD"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

  # Ignore ephemeral changes in GKE-managed fields so Terraform won't attempt to remove them.
  lifecycle {
    ignore_changes = [
      # Examples of fields GKE often auto-sets or modifies:
      node_config[0].kubelet_config,
      node_config[0].resource_labels,
      node_config[0].tags,
    ]
  }
}
