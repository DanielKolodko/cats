## Cats Devops project

Welcome to the Cats DevOps project! This repository serves as the central hub for our DevOps automation that builds, deploys, and manages a cat gifs application on Google Cloud Platform (GCP). The project leverages modern CI/CD practices, Terraform, Docker, Helm, and monitoring tools to create and maintain a robust Kubernetes infrastructure on GKE.
## Project goals:
# Automated infrastructure provisioning 

Use Terraform to provision and manage the underlying GKE cluster and other GCP resources.
Terraform state is stored remotely in a Google Cloud Storage (GCS) bucket for consistency and collaboration.

# Continious integration and deployment

CI Pipeline: Builds, tests, and pushes the Docker image of the application to Docker Hub.
CD Pipeline: Uses Terraform to create/update the Kubernetes infrastructure and Helm to deploy the application into the GKE cluster.

# Helm chart managment

Package and deploy the application via a Helm chart for consistent deployments and easy rollbacks.

# Monitoring with Grafana & Prometheus

Prometheus:
Prometheus is used to collect, store, and query metrics from your application and cluster. It scrapes metrics endpoints (like the /metrics endpoint on your Flask app) at regular intervals, providing a powerful time series database. With PromQL, you can create queries to monitor application performance, resource utilization, and trigger alerts when certain conditions are met.

Grafana:
Grafana is a visualization tool that connects to Prometheus (and other data sources) to build interactive dashboards. With Grafana, you can visualize trends, monitor real-time metrics, and set up alerts to notify you when key metrics exceed thresholds. In this project, Grafana dashboards help you monitor the health and performance of both the application and the underlying infrastructure.

# Automated cleanup

A scheduled cleanup pipeline removes old Docker images and Helm chart packages (from Docker Hub and GCS) that are older than 30 days.

## How it operates
1. # Code commit & tagging

Source Code Repository:
All application code, Terraform configurations, Helm charts, and CI/CD pipeline definitions are stored in this repository (cats.git).
Triggers:
Code commits and tag pushes (e.g., v1.0.0, v0.2.0) trigger the pipelines.

2. # Continuous integration(CI)

Docker Image Build:
The CI pipeline builds a Docker image for the cat gifs application and pushes it to Docker Hub. This image is versioned and becomes the deployment artifact.
Testing:
Automated tests ensure that the image is production-ready before deployment.

3. # Infrastructure provisioning with Terraform 

Remote State Management:
Terraform uses a Google Cloud Storage bucket as a remote backend to store state files, ensuring consistency.
GKE Cluster Provisioning:
Terraform provisions a Google Kubernetes Engine (GKE) cluster and associated node pools in GCP.
Resource Import:
Existing resources (like a storage bucket, GKE cluster, or node pool) are imported into Terraform state to avoid conflicts.

4. # Comtinuous deployment (CD)

Helm Deployments:
The CD pipeline uses Helm to deploy the application to the GKE cluster. The Helm chart references the Docker image built in the CI pipeline, ensuring the correct image is deployed.
GKE Credentials:
The CD pipeline configures kubectl to connect to the GKE cluster, enabling Helm to perform deployments.

5. # Monitoring & visualization 

Prometheus & Grafana Deployment:
As part of the CD pipeline, the project deploys the kube-prometheus-stack (or a similar monitoring stack) using Helm. This stack includes Prometheus for scraping metrics from your application (via a ServiceMonitor) and Grafana for visualizing these metrics.
Metrics & Dashboards:
Prometheus collects metrics such as application performance data and resource usage. Grafana then uses these metrics to create interactive dashboards, providing insights into the health and performance of your application and infrastructure.

6. # Cleanup pipeline

Scheduled Cleanup:
Runs automatically on a schedule to remove old artifacts, helping to manage storage usage and keep repositories tidy.

7. # Terraform destroy pipeline

Tear Down Infrastructure:
A manually triggered pipeline allows you to tear down the entire infrastructure when necessary.

## Prerequisites

Google Cloud Platform (GCP):
Set up a GCP project with the required quotas and permissions.
Service Account:
A service account key (GCP_SA_KEY) is required for authentication. Ensure the service account has roles like Storage Object Creator and Kubernetes Engine Admin.
Docker Hub:
Credentials (DOCKERHUB_USERNAME and DOCKERHUB_TOKEN) are needed to push Docker images.
Helm:
Helm charts are used to deploy the application to GKE.
Monitoring Tools:
The monitoring stack (Grafana and Prometheus) is deployed as part of the CD pipeline using Helm.

## How to run:

CI Pipeline:
Push a commit or a new tag to automatically build and push the Docker image.
CD Pipeline:
Push a new tag (or trigger manually) to provision/update infrastructure and deploy the application.
Monitoring:
Once the CD pipeline completes, access Grafana (typically via a service endpoint) to view dashboards and alerts generated from Prometheus metrics.
Cleanup Pipeline:
Runs automatically on a schedule to remove old artifacts.
Terraform Destroy Pipeline:
Manually trigger this pipeline if you need to tear down the infrastructure.