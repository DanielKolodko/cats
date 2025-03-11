# CATS DEVOPS PROJECT

Welcome to the Cats DevOps project! This repository serves as the central hub for our DevOps automation that builds, deploys, and manages a cat gifs application on Google Cloud Platform (GCP). The project leverages modern CI/CD practices, Terraform, Docker, and Helm to create and maintain a robust Kubernetes infrastructure on GKE.

# PROJECT GOALS

## AUTOMATED INFRASTRUCTURE PROVISIONING
- Use Terraform to provision and manage the underlying GKE cluster and other GCP resources.
- Terraform state is stored remotely in a Google Cloud Storage (GCS) bucket for consistency and collaboration.

## CONTINUOUS INTEGRATION AND DEPLOYMENT
- **CI Pipeline:** Builds, tests, and pushes the Docker image of the application to Docker Hub.
- **CD Pipeline:** Uses Terraform to create/update the Kubernetes infrastructure and Helm to deploy the application into the GKE cluster.

## HELM CHART MANAGEMENT
- Package and deploy the application via a Helm chart for consistent deployments and easy rollbacks.

## AUTOMATED CLEANUP
- A scheduled cleanup pipeline removes old Docker images and Helm chart packages (from Docker Hub and GCS) that are older than 30 days.

# HOW IT OPERATES

## 1. CODE COMMIT & TAGGING
- **Source Code Repository:**  
  All application code, Terraform configurations, Helm charts, and CI/CD pipeline definitions are stored in this repository ([cats.git](https://github.com/DanielKolodko/cats.git)).
- **Triggers:**  
  Code commits and tag pushes (e.g., `v1.0.0`, `v0.2.0`) trigger the pipelines.

## 2. CONTINUOUS INTEGRATION (CI)
- **Docker Image Build:**  
  The CI pipeline builds a Docker image for the cat gifs application and pushes it to Docker Hub. This image is versioned and becomes the deployment artifact.
- **Testing:**  
  Automated tests ensure that the image is production-ready before deployment.

## 3. INFRASTRUCTURE PROVISIONING WITH TERRAFORM
- **Remote State Management:**  
  Terraform uses a Google Cloud Storage bucket as a remote backend to store state files, ensuring consistency.
- **GKE Cluster Provisioning:**  
  Terraform provisions a Google Kubernetes Engine (GKE) cluster and associated node pools in GCP.
- **Resource Import:**  
  Existing resources (like a storage bucket, GKE cluster, or node pool) are imported into Terraform state to avoid conflicts.

## 4. CONTINUOUS DEPLOYMENT (CD)
- **Helm Deployments:**  
  The CD pipeline uses Helm to deploy the application to the GKE cluster. The Helm chart references the Docker image built in the CI pipeline, ensuring the correct image is deployed.
- **GKE Credentials:**  
  The CD pipeline configures `kubectl` to connect to the GKE cluster, enabling Helm to perform deployments.

## 5. CLEANUP PIPELINE
- **Scheduled Cleanup:**  
  A scheduled pipeline runs daily but only deletes Docker images and Helm chart packages older than 30 days, managing storage usage and keeping repositories tidy.

## 6. TERRAFORM DESTROY PIPELINE
- **Tear Down Infrastructure:**  
  A manually triggered pipeline (Terraform Destroy Pipeline) allows you to tear down the entire infrastructure when necessary.

# PREREQUISITES

- **Google Cloud Platform (GCP):**  
  Set up a GCP project with the required quotas and permissions.
- **Service Account:**  
  A service account key (`GCP_SA_KEY`) is required for authentication. Ensure the service account has roles like Storage Object Creator and Kubernetes Engine Admin.
- **Docker Hub:**  
  Credentials (`DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`) are needed to push Docker images.
- **Helm:**  
  Helm charts are used to deploy the application to GKE.

# HOW TO RUN

- **CI Pipeline:**  
  Push a commit or a new tag to automatically build and push the Docker image.
- **CD Pipeline:**  
  Push a new tag (or trigger manually) to provision/update infrastructure and deploy the application.
- **Cleanup Pipeline:**  
  Runs automatically on a schedule to remove old artifacts.
- **Terraform Destroy Pipeline:**  
  Manually trigger this pipeline if you need to tear down the infrastructure.
