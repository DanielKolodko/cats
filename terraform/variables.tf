variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for the cluster"
  type        = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "The machine type for nodes in the node pool"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "The disk size in GB for each node"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "The type of disk for nodes (e.g., pd-standard, pd-ssd)"
  type        = string
  default     = "pd-standard"
}
