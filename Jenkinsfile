pipeline {
    // Use any available agent.
    agent any

    // This block tells Jenkins to find the Maven installation named 'M3'
    // and add it to the PATH for this pipeline's execution.
    tools {
        maven 'M3'
    }

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
                // This 'mvn' command will now work because of the 'tools' block above.
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building the Docker image using docker-maven-plugin..."
                // We explicitly tell the plugin to use the Docker socket, overriding any environment variables.
                sh 'mvn -Ddocker.host=unix:///var/run/docker.sock docker:build'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker Image to DockerHub..."
                withRegistry(registry: 'https://registry.hub.docker.com', credentialsId: 'shyambista-docker') {
                    // We also specify the docker.host here for the push goal.
                    sh 'mvn -Ddocker.host=unix:///var/run/docker.sock docker:push'
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
