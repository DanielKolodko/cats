variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region where the cluster will be created"
  type        = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "The machine type for the nodes in the node pool"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "The disk size in GB for each node"
  type        = number
  default     = 100
}

variable "disk_type" {
  description = "The disk type for nodes (for example, pd-standard or pd-ssd)"
  type        = string
  default     = "pd-standard"
}
