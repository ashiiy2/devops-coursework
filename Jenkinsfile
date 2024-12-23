pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS = credentials('dockerhub-credentials') // ID of DockerHub credentials
        GITHUB_CREDENTIALS = credentials('github-credentials')   // ID of GitHub credentials
        REGISTRY = 'docker.io'
        IMAGE_NAME = 'ayaqub300/cw2-server'
        IMAGE_TAG = '1.0' // Fixed tag to overwrite existing one
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', // Ensure 'master' is your default branch
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/ashiiy2/devops-coursework.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'node server.js &'
                        sleep 10
                        sh 'curl http://localhost:8080/'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", 'dockerhub-credentials') {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
                    kubectl set image deployment/cw2-server-deployment cw2-server=${IMAGE_NAME}:${IMAGE_TAG} --record
                    kubectl rollout status deployment/cw2-server-deployment
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
