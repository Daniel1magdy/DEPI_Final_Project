pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'danielmagdy/final_project:latest'
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Clone the GitHub repository
                    git 'https://github.com/Omareldeeb7/Final_Project.git'
                }
            }
        }

        stage('Build and Test') {
            steps {
                script {
                    // Build the project using Maven
                    sh './mvnw clean package -DskipTests'
                    
                    // Run tests using Maven
                    sh './mvnw test'
                }
            }
        }

        stage('Dockerize Application') {
            steps {
                script {
                    // Build Docker image and tag it
                    sh 'docker build -t $DOCKER_IMAGE .'

                    // Login to DockerHub (using Jenkins credentials)
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }

                    // Push the Docker image to DockerHub
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy with Ansible') {
            steps {
                script {
                    // Run the Ansible playbook to deploy the app
                    sh 'ansible-playbook -i hosts deploy.yml'
                }
            }
        }

        stage('Apply Monitoring with Prometheus') {
            steps {
                script {
                    // Add commands to apply Prometheus monitoring
                    // For example, you could run a script or deploy Prometheus to the server
                    sh './deploy-prometheus.sh'
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Clean up Docker images
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }

        failure {
            echo 'Pipeline failed. Please check the logs for errors.'
        }
    }
}

