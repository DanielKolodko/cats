terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = "onyx-seeker-451213-q9"    # Replace with your GCP project ID
  region  = "us-central1"
}

resource "google_compute_instance" "ubuntu_instance" {
  name         = "ubuntu-instance"
  machine_type = "e2-micro"       # Choose an appropriate machine type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"  # Using Ubuntu 20.04 LTS
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Allocate a public IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    # Update packages and install Apache as an example
    apt-get update -y
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2

    # Optional: Install Docker and docker-compose if you plan to run your Flask project with docker-compose
    apt-get install -y docker.io docker-compose
    systemctl enable docker
    systemctl start docker
  EOF
}

output "instance_public_ip" {
  value = google_compute_instance.ubuntu_instance.network_interface[0].access_config[0].nat_ip
}

