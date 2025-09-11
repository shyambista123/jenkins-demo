pipeline {
    agent {
        node {
            label 'maven-agent-alpine'
        }
    }
    triggers {
            pollSCM '* * * * *'
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

// pipeline {
//     agent {
//         node {
//             label 'docker-agent'
//         }
//     }
//     triggers {
//             pollSCM 'H/5 * * * *'
//      }
//      environment {
//          DOCKERHUB_CREDENTIALS = credentials('shyambista-docker')
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
//                 docker build -t shyambist/jenkis-demo:latest .
//                 '''
//             }
//         }
//         stage('Login') {
//             steps {
//                 sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
//             }
//         }
//         stage('Push') {
//             steps {
//                 echo "Push Docker Image to DockerHub"
//                 sh '''
//                 docker push shyambist/jenkis-demo:latest
//                 '''
//             }
//         }
//     }
//     post {
//         success {
//             echo "Build, test, and push were successful!"
//         }
//         failure {
//             echo "Build, test, or push failed. Check the logs for details."
//         }
//         always {
//               sh 'docker logout'
//         }
//     }
// }
