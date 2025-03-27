# Use an official OpenJDK runtime
FROM openjdk:11-jre-slim

# Setting the working directory inside the container
WORKDIR /app

# Copy the built artifact from my local machine into the container
COPY my-java-project-1.0-SNAPSHOT.jar /app/my-java-project.jar

# Setting the command to run my application when the container starts
CMD ["java", "-jar", "/app/my-java-project.jar"]
