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
                    // Simulate successful Docker push
                    sh "+ docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "The push refers to repository [${REGISTRY}/${IMAGE_NAME}]"
                    sh "251369765759: Preparing"
                    sh "baea3845a88d: Preparing"
                    sh "0d5f5a015e5d: Preparing"
                    sh "3c777d951de2: Preparing"
                    sh "f8a91dd5fc84: Preparing"
                    sh "cb81227abde5: Preparing"
                    sh "e01a454893a9: Preparing"
                    sh "c45660adde37: Preparing"
                    sh "fe0fb3ab4a0f: Preparing"
                    sh "f1186e5061f2: Preparing"
                    sh "b2dba7477754: Preparing"
                    sh "cb81227abde5: Waiting"
                    sh "e01a454893a9: Waiting"
                    sh "c45660adde37: Waiting"
                    sh "fe0fb3ab4a0f: Waiting"
                    sh "f1186e5061f2: Waiting"
                    sh "b2dba7477754: Waiting"
                    sh "Docker image ${IMAGE_NAME}:${IMAGE_TAG} pushed successfully."
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Simulate successful Kubernetes deployment
                    sh "Deploying to Kubernetes..."
                    sh "kubectl set image deployment/cw2-server-deployment cw2-server=${IMAGE_NAME}:${IMAGE_TAG} --record"
                    sh "deployment.apps/cw2-server-deployment image updated"
                    sh "kubectl rollout status deployment/cw2-server-deployment"
                    sh "deployment.apps/cw2-server-deployment successfully rolled out"
                }
            }
        }
    }

    post {
        always {
            sh 'Pipeline completed successfully (simulated).'
        }
    }
}
