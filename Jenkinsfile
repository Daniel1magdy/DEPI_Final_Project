pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'danielmagdy/final_project:latest'
        DOCKER_CREDENTIALS_ID = 'DOCKER_CREDENTIALS_ID'
	}

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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
		    // withEnv(['ANSIBLE_BECOME_PASSWORD=123']) {
                    // Run the Ansible playbook to deploy the app
                    sh 'ansible-playbook -i ansible/inventory.ini ansible/deploy.yml'
                // }
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
