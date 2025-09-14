pipeline {
    // Define a self-contained agent that is a Docker container.
    // This makes the pipeline reliable and independent of global agent configurations.
    agent {
        docker {
            // Use a Maven image that includes JDK 21 to match the project's pom.xml.
            image 'maven:3.9.8-eclipse-temurin-21'
            // Run as root and mount the host's Docker socket into the container.
            // This allows the 'mvn' command inside the container to talk to your
            // host's Docker daemon, which is the standard "Docker-out-of-Docker" pattern.
            args '-v /var/run/docker.sock:/var/run/docker.sock --user root'
        }
    }

    // The 'tools' block is no longer needed because Maven is part of the agent image.

    triggers {
        pollSCM 'H/5 * * * *'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from repository..."
                checkout scm
            }
        }

        stage('Package Application') {
            steps {
                echo "Compiling and packaging the Spring Boot application..."
                sh 'mvn clean package'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                echo "Building and Pushing Docker Image to DockerHub..."
                // 'withRegistry' securely handles login and logout to Docker Hub.
                withRegistry(registry: 'https://registry.hub.docker.com', credentialsId: 'shyambista-docker') {
                    // The docker-maven-plugin automatically finds the mounted Docker socket.
                    // We can run both goals in a single, efficient command.
                    sh 'mvn docker:build docker:push'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}

// pipeline {
//     agent {
//         node {
//             label 'maven-agent-alpine'
//         }
//     }
//     triggers {
//             pollSCM '* * * * *'
//      }
//     stages {
//         stage('Checkout') {
//             steps {
//                 echo "Checking out code from repository..."
//                 checkout scm
//             }
//         }
//         stage('Build') {
//             steps {
//                 echo "Building the Spring Boot application..."
//                 sh '''
//                 mvn clean install -DskipTests
//                 '''
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo "Running tests..."
//                 sh '''
//                 mvn test
//                 '''
//             }
//         }
//         stage('Package JAR') {
//             steps {
//                 echo "Packaging the JAR..."
//                 sh '''
//                 mvn package
//                 '''
//             }
//         }
//         stage('Deliver') {
//             steps {
//                 echo "Delivering the JAR..."
//                 sh '''
//                 echo "doing delivery stuff.."
//                 java -jar target/*.jar
//                 '''
//             }
//         }
//     }
//     post {
//         success {
//             echo "Build, test, and delivery were successful!"
//         }
//         failure {
//             echo "Build, test, or delivery failed. Check the logs for details."
//         }
//     }
// }
