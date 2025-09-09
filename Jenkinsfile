pipeline {
    agent {
        node {
            label 'docker-agent-alpine'
            }
      }
    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from repository..."
                checkout scm
            }
        }
        stage('Build') {
            steps {
                echo "Building the Spring Boot application..."
                sh '''
                mvn clean install -DskipTests
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                sh '''
                mvn test
                '''
            }
        }
        stage('Package JAR') {
            steps {
                echo "Packaging the JAR..."
                sh '''
                mvn package
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo "Delivering the JAR..."
                sh '''
                echo "doing delivery stuff.."
                java -jar target/*.jar
                '''
            }
        }
    }
    post {
        success {
            echo "Build, test, and delivery were successful!"
        }
        failure {
            echo "Build, test, or delivery failed. Check the logs for details."
        }
    }
}