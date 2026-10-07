pipeline {
    // This tells Jenkins to run this pipeline ON THE AGENT we just set up!
    agent {
        label 'docker'
    }

    // Automatically trigger the pipeline on GitHub push events
    triggers {
        githubPush()
    }

    environment {
        // Our ECR Repository URL
        ECR_REPO = "365957110061.dkr.ecr.us-east-1.amazonaws.com/devsecops-app"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        AWS_REGION = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Install Prerequisites (Trivy & AWS CLI)') {
            steps {
                echo 'Installing Trivy & AWS CLI on the Agent...'
                sh '''
                    # Install AWS CLI if not present
                    if ! command -v aws > /dev/null 2>&1; then
                        sudo apt-get update && sudo apt-get install -y awscli
                    fi

                    # Install Trivy if not present
                    if ! command -v trivy > /dev/null 2>&1; then
                        sudo apt-get install -y wget apt-transport-https gnupg lsb-release
                        wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/trivy.gpg
                        echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/trivy.list
                        sudo apt-get update && sudo apt-get install -y trivy
                    fi
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    echo 'Building the Docker image...'
                    sh 'docker build -t ${ECR_REPO}:${IMAGE_TAG} -t ${ECR_REPO}:latest .'
                }
            }
        }

        stage('Security Scan (Trivy)') {
            steps {
                echo 'Scanning image for vulnerabilities...'
                // Fails the pipeline if CRITICAL vulnerabilities are found
                sh 'trivy image --severity CRITICAL --exit-code 1 --no-progress ${ECR_REPO}:latest'
            }
        }

        stage('Push to AWS ECR') {
            steps {
                echo 'Logging into AWS ECR (using IAM Role)...'
                // Uses the IAM Role attached to the EC2 instance for passwordless login!
                sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}'
                
                echo 'Pushing Docker image to ECR...'
                sh 'docker push ${ECR_REPO}:${IMAGE_TAG}'
                sh 'docker push ${ECR_REPO}:latest'
            }
        }
    }
}
