Cats DevOps Project

Welcome to the Cats DevOps project! This repository serves as the central hub for our DevOps automation that builds, deploys, and manages a cat gifs application on Google Cloud Platform (GCP). The project leverages modern CI/CD practices, Terraform, Docker, and Helm to create and maintain a robust Kubernetes infrastructure on GKE.
Project Goals

    Automated Infrastructure Provisioning:
    Use Terraform to provision and manage the underlying GKE cluster and other GCP resources. The Terraform state is stored remotely in a Google Cloud Storage (GCS) bucket, enabling consistent and collaborative management.

    Continuous Integration and Deployment:
    Utilize GitHub Actions for a multi-stage CI/CD pipeline:
        CI Pipeline: Builds, tests, and pushes the Docker image of the application to Docker Hub.
        CD Pipeline: Uses Terraform to create or update the Kubernetes infrastructure and Helm to deploy the application into the GKE cluster.

    Helm Chart Management:
    Package and deploy the application via a Helm chart, ensuring consistent deployments and easy rollbacks.

    Automated Cleanup:
    A scheduled cleanup pipeline removes old Docker images and Helm chart packages from storage (Docker Hub and GCS) to keep the repositories tidy.

How It Operates
1. Code Commit & Tagging

    Source Code Repository:
    All application code, Terraform configurations, Helm charts, and CI/CD pipeline definitions are stored in this repository (cats.git).
    Triggers:
    Code commits and tag pushes (e.g., v1.0.0, v0.2.0) trigger the pipelines.

2. Continuous Integration (CI)

    Docker Image Build:
    The CI pipeline builds a Docker image for the cat gifs application and pushes it to Docker Hub. This image is versioned and becomes the artifact used for deployments.
    Testing:
    Automated tests ensure that the image is production-ready before deployment.

3. Infrastructure Provisioning with Terraform

    Remote State Management:
    Terraform uses a Google Cloud Storage bucket as a remote backend to store state files, ensuring consistency across environments.
    GKE Cluster Provisioning:
    Terraform provisions a Google Kubernetes Engine (GKE) cluster and associated node pools in GCP. The configuration is managed via Terraform files in the repository.
    Resource Import:
    If certain resources already exist (e.g., a storage bucket, GKE cluster, or node pool), Terraform imports them into state to avoid conflicts.

4. Continuous Deployment (CD)

    Helm Deployments:
    The CD pipeline uses Helm to deploy the application to the GKE cluster. The Helm chart references the Docker image built in the CI pipeline, ensuring the correct image is deployed.
    GKE Credentials:
    The CD pipeline configures kubectl to connect to the GKE cluster, allowing Helm to perform deployments.

5. Cleanup Pipeline

    Scheduled Cleanup:
    A separate scheduled pipeline runs periodically (daily) but only removes Docker images and Helm chart packages older than 30 days. This helps in managing storage usage and keeping the repositories clean.

6. Terraform Destroy Pipeline

    Tear Down Infrastructure:
    A manually triggered pipeline (Terraform Destroy Pipeline) allows you to tear down the entire infrastructure when necessary.

Prerequisites

    Google Cloud Platform (GCP):
    Set up a GCP project with the required quotas and permissions.
    Service Account:
    A service account key (GCP_SA_KEY) is required for authentication in your pipelines. Ensure the service account has the necessary roles (e.g., Storage Object Creator, Kubernetes Engine Admin).
    Docker Hub:
    Credentials for Docker Hub (DOCKERHUB_USERNAME and DOCKERHUB_TOKEN) are used to push Docker images.
    Helm:
    Helm charts are used to deploy the application to GKE.

Repository Structure

.
├── terraform/                # Terraform configurations for GCP infrastructure
│   ├── main.tf               # Main Terraform configuration (GKE cluster, etc.)
│   ├── variables.tf          # Variables definitions
│   ├── outputs.tf            # Terraform outputs
│   └── storage-bucket.tf     # (Optional) Terraform configuration for storage bucket
├── helmchart/                # Helm chart for the cat gifs application
│   ├── Chart.yaml            # Chart metadata
│   ├── templates/            # Kubernetes manifest templates
│   └── values.yaml           # Default values for the chart
├── .github/                  # GitHub Actions workflows
│   ├── ci.yml                # CI pipeline (builds & pushes Docker image)
│   ├── cd.yml                # CD pipeline (Terraform, Helm deployment)
│   └── cleanup.yml           # Cleanup pipeline (removes old images/charts)
├── app/                      # Application source code (cat gifs app)
└── README.md                 # This file

How to Run

    CI Pipeline:
    Push a commit or a new tag to automatically build and push the Docker image.
    CD Pipeline:
    Push a new tag (or trigger manually) to provision/update infrastructure and deploy the app.
    Cleanup Pipeline:
    Runs automatically on a schedule.
    Terraform Destroy:
    Manually trigger the destroy pipeline if you need to tear down the infrastructure.
