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
                    git 'https://github.com/Daniel1magdy/DEPI_Final_Project.git'
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
                    withCredentials([usernamePassword(credentialsId: 'DOCKER_CREDENTIALS_ID', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }

                    // Push the Docker image to DockerHub
                    sh 'docker push $DOCKER_IMAGE'
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


