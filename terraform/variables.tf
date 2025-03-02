variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the cluster"
  type        = string
  default     = "us-central1"
}

variable "master_version" {
  description = "The GKE master version to use for the cluster and node pool"
  type        = string
  default     = "1.31.5-gke.1068000"
}

variable "machine_type" {
  description = "The machine type for nodes in the node pool"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "The disk size (in GB) for each node"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "The type of disk for nodes (for example, pd-standard or pd-ssd)"
  type        = string
  default     = "pd-standard"
}
