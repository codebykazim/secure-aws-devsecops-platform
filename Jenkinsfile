pipeline {
    // This tells Jenkins to run this pipeline ON THE AGENT we just set up!
    agent {
        label 'docker'
    }

    environment {
        // Name of our Docker image
        IMAGE_NAME = "devsecops-app"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                // We will add the actual checkout step once we initialize Git
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('app') {
                    echo 'Building the Docker image...'
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest .'
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                echo 'Testing the newly built image...'
                // Run the container in the background
                sh 'docker run -d -p 3000:3000 --name test-app ${IMAGE_NAME}:latest'
                
                // Wait for the server to start
                sh 'sleep 5'
                
                // Check if the health endpoint returns 200 OK
                sh 'curl -s -f http://localhost:3000/health || (echo "Healthcheck failed"; exit 1)'
            }
            post {
                always {
                    // Clean up the running container regardless of success or failure
                    sh 'docker stop test-app || true'
                    sh 'docker rm test-app || true'
                }
            }
        }
    }
}
