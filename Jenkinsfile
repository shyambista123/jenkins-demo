pipeline {
    // Use any available agent. This completely avoids the 'docker-agent' configuration issues.
    // This agent only needs to have Java and Maven installed.
    agent any

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

        stage('Build Application') {
            steps {
                echo "Compiling and packaging the Spring Boot application..."
                // Standard Maven command to build the JAR/WAR file.
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image using docker-maven-plugin..."
                // This command tells the Maven plugin to build the image from your Dockerfile.
                sh 'mvn docker:build'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker Image to DockerHub..."
                // Use 'withRegistry' for secure, automatic login and logout.
                // This is the modern, safe way to handle credentials.
                withRegistry(registry: 'https://registry.hub.docker.com', credentialsId: 'shyambista-docker') {
                    // This command tells the Maven plugin to push the image.
                    // The plugin automatically uses the credentials provided by withRegistry.
                    sh 'mvn docker:push'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
            // The 'withRegistry' block handles logout automatically, so we don't need 'docker logout'.
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
