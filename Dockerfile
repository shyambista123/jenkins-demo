#FROM maven:3.9.5-eclipse-temurin-21 AS build
#WORKDIR /app
#
#COPY pom.xml .
#RUN mvn dependency:go-offline
#
#COPY src ./src
#RUN mvn clean package -DskipTests
#
#FROM eclipse-temurin:21-jdk-jammy
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "app.jar"]

# Use a base image with Java installed
FROM openjdk:21-jdk-slim

# Set working directory
WORKDIR /app

# Copy the application's JAR file into the container
COPY target/*.jar app.jar

# Expose the port your application listens on
EXPOSE 8080

# Define the command to run your application when the container starts
ENTRYPOINT ["java", "-jar", "app.jar"]
