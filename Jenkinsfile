pipeline {
    agent any
    stages {
        // Checkout the code
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        // Build the Java application using Maven
        stage('Build & Test') {
            steps {
                script {
                    // Run mvn clean package to build the .war file
                    sh './mvnw clean package'
                    
                    // Run tests using Maven
                    sh './mvnw test'
                }
            }
        }
        
        // Dockerize the application
        stage('Dockerize') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t danielmagdy/newone:latest .'
                    
                    // Log into DockerHub (using credentials)
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    
                    // Push Docker image to DockerHub
                    sh 'docker push danielmagdy/newone:latest'
                }
            }
        }
    }
}
