# Spring Boot Jenkins Demo

This is a simple Spring Boot project created to demonstrate a basic CI pipeline using Jenkins.

## Project Contents

- Spring Boot application (Java)
- Maven build system
- Jenkinsfile for CI pipeline

## Jenkins Pipeline Stages

The Jenkinsfile defines the following stages:

1. Checkout - Pulls code from GitHub
2. Build - Runs 'mvn clean install -DskipTests'
3. Test - Runs 'mvn test'
4. Package JAR - Builds the application JAR
5. Deliver - Runs the packaged JAR and prints a message

The pipeline also polls the Git repository every minute for changes.

## How the Deliver Stage Works

In the Deliver stage, the JAR is executed using:

    java -jar target/*.jar

To prevent the pipeline from hanging, the application's main method is designed to print a message and exit immediately.

## Running Locally

To build and run the app locally:

    mvn clean install
    java -jar target/*.jar

Make sure Java and Maven are installed on your system.

## Running with Jenkins

To run this project using Jenkins:

1. Create a new Jenkins Pipeline job.
2. Point it to this GitHub repository.
3. Jenkins will detect the Jenkinsfile and execute the pipeline.

Ensure your Jenkins agent has:

- Java and Maven installed, or
- Uses a Docker image like 'maven:3.9.5-eclipse-temurin-21'

## Output

The packaged JAR file will be located in the 'target/' directory after a successful build.

## Purpose

This project is for learning and demonstrating:

- Jenkins declarative pipelines
- Continuous integration with Spring Boot
- Basic CI/CD automation

