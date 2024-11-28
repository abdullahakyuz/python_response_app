# Python Response App with Terraform, Docker, Kubernetes, and Jenkins

This project is a Python-based API application integrated with DevOps tools like Terraform, Docker, Kubernetes, and Jenkins. It provides a fully automated and scalable infrastructure, deployed on AWS EC2 instances. Monitoring is included via Prometheus and Grafana.

---

## Prerequisites

Before starting, ensure you have the following installed and configured:

- **AWS CLI** and an AWS account
- **Terraform**
- **Docker**
- **Kubernetes** (Minikube or AWS EKS recommended)
- **Jenkins**
- **Prometheus & Grafana**

---

## Project Overview

### AWS Infrastructure with Terraform

The project uses **Terraform** to manage AWS resources. This setup deploys two EC2 instances:
- **App Server**: Hosts the Python application.
- **Database Server**: Runs MongoDB.

Steps to set up the infrastructure:
1. Navigate to the `terraform` directory.
2. Initialize Terraform:
   ```bash
   terraform init
terraform apply

This creates the required EC2 instances with security groups and necessary IAM roles.

Docker Setup
Building the Docker Image

1.    Clone the repository:

    git clone https://github.com/abdullahakyuz/python_response_app.git
cd python_response_app


2.    Build the Docker image:
  docker build -t your-dockerhub/python-response-app .

3.    Push the image to Docker Hub:
  docker push your-dockerhub/python-response-app

### Running Locally

You can test the application locally using the following command:
docker run -p 5000:5000 your-dockerhub/python-response-app

## Kubernetes Deployment

Use the Kubernetes YAML files located in the k8s/ directory to deploy the application.

Steps to deploy:

1.    Apply the deployment configuration:
  kubectl apply -f k8s/
