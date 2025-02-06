# Use an official Tomcat base image
FROM tomcat:9-jdk11-openjdk-slim

# Set the working directory
WORKDIR /usr/local/tomcat/webapps

# Copy the .war file to the Tomcat webapps folder
COPY target/jpetstore.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

