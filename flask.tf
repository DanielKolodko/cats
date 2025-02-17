resource "google_compute_instance" "flask" {
  name         = "flask-instance"
  machine_type = "n1-standard-1"        # You might need a bit more power for Docker
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network       = "default"
    access_config {}                    # Assign a public IP
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose git
    systemctl enable docker
    systemctl start docker
    # Clone your flask project repo (or use your own repository)
    git clone https://github.com/DanielKolodko/cats.git /opt/flask-project
    cd /opt/flask-project
    docker-compose up -d
  EOF
}

output "flask_instance_ip" {
  value = google_compute_instance.flask.network_interface[0].access_config[0].nat_ip
}
