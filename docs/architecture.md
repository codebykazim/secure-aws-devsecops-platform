# High-Level Architecture Overview

## 1. Infrastructure (Terraform)
- **VPC:** Custom VPC with subnets.
- **EC2 Instances:**
  - Jenkins/Ansible Controller Node
  - Jenkins Agent Node (for running builds)
- **EKS Cluster:** Managed Kubernetes cluster for application hosting.

## 2. Configuration Management (Ansible)
- Automates the installation of Jenkins, Docker, and monitoring prerequisites.
- Implements OS hardening and firewall rules.

## 3. CI/CD Pipeline Flow (Jenkins)
1. **Developer Commits Code** to GitHub.
2. **GitHub Webhook** triggers Jenkins.
3. **Jenkins Agent** pulls code.
4. **Code Quality Analysis** runs via SonarCloud.
5. **Docker Build** creates the application image.
6. **Security Scan** (Trivy) checks the image for vulnerabilities.
7. **Push** to Docker Hub / JFrog.
8. **Deployment** to AWS EKS cluster.
9. **Email Notifications** sent for success/failure.

## 4. Monitoring & Alerting
- Prometheus scrapes metrics from EKS and EC2 nodes.
- Grafana visualizes the metrics.
- Alertmanager routes critical alerts to email.
