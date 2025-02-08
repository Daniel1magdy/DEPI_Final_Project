### Final Java DevOps CI/CD project.

## Description 

This is a Java web app that needs to have an automated CI/CD using the DevOps toolset. The Application is running as a container on the same VM on port 8080.

## The used tools

- Git/Github -> clone the code.
- Maven -> build the code.
- Docker -> dockerize the app
- Jenkins -> CI/CD
- Ansible -> deploy by running a container of the app
- Terraform (Plus) -> to create the EC2 on AWS 
- AWS (plus) -> EC2 machine that shall run the pipeline and host the application

## The Steps

CI/CD pipeline that do as following 

CI:
- Clone the source code.
- Build the code using mvnw (already in the repo)
- Test the code using mvnw (already in the repo)
- Dockerize the application and push it to dockerhub

CD:
- Deploy the application by running a container from the image using Ansible.
- Apply the monitoring on the machine using Prometheus. 


Github repo containes 
- The src code.
- The Dockerfile
- The Jenkinsfile
- The Ansible Playbook

## Note 

This application build is resulting a .war file not .jar as we saw before. This needs a change in the command that is used to run the application. We will use mvnw as well to run the application as shown below. Here's the command used to run the app:

./mvnw cargo:run -P tomcat90

## Thank You.
