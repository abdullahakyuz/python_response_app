# Python Response App with Terraform, Docker, Kubernetes, and Jenkins

This project is a Python-based API application integrated with DevOps tools like Terraform, Docker, Kubernetes, and Jenkins. It provides a fully automated and scalable infrastructure, deployed on AWS EC2 instances. Monitoring is included via Prometheus and Grafana.

## Prerequisites

Before you begin, make sure you have the following installed and configured:

- **AWS EC2 instances**
- **Docker**
- **Kubernetes**
- **Jenkins**
- **Terraform**
- **Prometheus & Grafana** (for monitoring)

## Project Structure

### AWS EC2 Infrastructure with Terraform

The infrastructure for this project is managed using **Terraform**. To set up the architecture, follow these steps:

1. Review and customize the **Terraform** files to suit your environment.
2. Initialize the Terraform directory by running:
    ```bash
    terraform init
    ```
3. Apply the configuration to create resources in AWS:
    ```bash
    terraform apply
    ```

This project utilizes **2 AWS EC2 instances**:

- **Master-node**: Acts as the **Kubernetes master-node**.
- **Worker-node**: Serves as the **Kubernetes worker-node**.

### Docker Setup

#### Docker Image

- The Docker image can be built from the `Dockerfile` located in the main directory.
- Log in to Docker and upload the image to your Docker Hub.

    ```bash
    docker build .
    ```

### Congratulations! Your Project is now running!

## Kubernetes Setup

To run the project on **Kubernetes**, utilize the configuration files in the `k8s` directory. This setup includes:

- **Prometheus** and **Grafana** for monitoring.

You can access **Grafana** at port `32000` to view project metrics and monitor your application.

To deploy the project on Kubernetes, run:


    ```bash
    kubectl apply -f /k8s
    ```

## Congratulations! Your project is now running on Kubernetes with auto-scaling.

---

## CI/CD with Jenkins

To integrate your project into a **CI/CD pipeline** using **Jenkins**:

1. Access the **Jenkins** server at port `8080`.
2. Set up a **GitHub Webhook** to trigger builds from your GitHub repository.
3. Install the necessary **Jenkins plugins** for **Docker** and **Kubernetes** support.
4. Create a **Jenkins pipeline** using the `Jenkinsfile` located in the project’s root directory to automate the entire process.

With Jenkins, you can easily automate deployments and manage your **CI/CD workflows**!

---

## Conclusion

By following this guide, you can deploy and manage a **Python-based API** with a robust, automated, and scalable setup using Terraform, Docker, Kubernetes, and Jenkins. Observability is enhanced through Prometheus and Grafana, providing a production-ready environment for your application.
