pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'danielmagdy/final_project:latest'
        DOCKER_CREDENTIALS_ID = 'docker-credentials'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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


