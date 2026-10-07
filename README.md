# 🚀 Secure AWS DevSecOps Platform

## 📌 Project Overview
A fully automated, highly available, and secure DevSecOps platform deployed on AWS. This project demonstrates end-to-end continuous integration, continuous deployment (CI/CD), infrastructure as code (IaC), security scanning, and robust Kubernetes monitoring. 

The infrastructure is provisioned dynamically, configured securely, and hosts a containerized application with automated rollbacks and alerting.

## 🛠️ Tech Stack & Tools
* **Cloud Provider:** AWS (EC2, EKS, ECR, VPC, ALB)
* **Infrastructure as Code (IaC):** Terraform
* **Configuration Management:** Ansible
* **CI/CD:** Jenkins (Master-Agent architecture)
* **Containerization & Orchestration:** Docker, Kubernetes (Amazon EKS)
* **Security & Vulnerability Scanning:** Trivy
* **Monitoring & Alerting:** Prometheus, Grafana, Jenkins Mailer
* **Version Control:** Git, GitHub

---

## ✨ Key Features & Capabilities

### 1. Automated Infrastructure & Hardening
* **Terraform** provisions a custom VPC, EC2 instances for Jenkins (Master & Agent), and a fully managed 3-node EKS Cluster.
* **Ansible** configures the EC2 instances, installs dependencies, and enforces Linux security hardening (disabling root login, enforcing SSH key-only access, installing Fail2ban).

### 2. DevSecOps CI/CD Pipeline
* A dynamic `Jenkinsfile` orchestrates the build process.
* **Security First:** Integrates **Trivy** to scan the Docker image for vulnerabilities before pushing it to AWS ECR. The build fails if CRITICAL vulnerabilities are found.
* Securely authenticates with AWS via IAM Roles (no hardcoded access keys).

### 3. Kubernetes Deployment & Resiliency
* The application is deployed to **Amazon EKS** using a LoadBalancer service.
* Simulates real-world incidents (e.g., bad image deployments) and leverages Kubernetes native rolling updates and `rollout undo` capabilities for zero-downtime recovery. (See [Incident RCA](docs/rca-incident-01.md)).

### 4. Continuous Monitoring & Alerting
* Deploys **Prometheus** and **Grafana** via Helm to monitor cluster health, node resource usage, and pod metrics.
* Automated email alerts configured for pipeline successes/failures and Grafana metric thresholds.

---

## 📂 Repository Structure
```text
├── ansible/               # Ansible playbooks and roles for configuration management
├── app/                   # Source code and Dockerfile for the application
├── docs/                  # Architecture diagrams, incident RCAs, and screenshots
├── k8s/                   # Kubernetes deployment and service manifests
├── terraform/             # IaC definitions for AWS infrastructure and EKS
└── Jenkinsfile            # Declarative CI/CD pipeline definition
```

## 📸 Screenshots & Proof of Work
Visual proof of the working pipeline, EKS cluster, vulnerability scanning, and Grafana dashboards can be found in the [`docs/images/`](docs/images/) directory.

* **Jenkins Pipeline & Trivy Scans**
* **Grafana Monitoring Dashboards**
* **AWS EKS Nodes & EC2 Instances**

---
*Created by [Muhammad Kazim](https://github.com/codebykazim)*
