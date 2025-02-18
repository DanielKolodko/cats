variable "project" {
  description = "The Google Cloud project ID."
  type        = string
  default     = "onyx-seeker-451213-q9"
}

variable "region" {
  description = "The Google Cloud region to deploy the cluster."
  type        = string
  default     = "us-central1"
}

variable "machine_type" {
  description = "The machine type to use for the GKE node pool."
  type        = string
  default     = "e2-medium"
}
