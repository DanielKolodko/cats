variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "node_version" {
  description = "The node version if you want to pin it (optional)"
  type        = string
  default     = "1.31.5-gke.1068000"
}

variable "machine_type" {
  description = "The machine type for the nodes"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "The disk size (GB) for each node"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "The disk type for the nodes (e.g., pd-standard)"
  type        = string
  default     = "pd-standard"
}

