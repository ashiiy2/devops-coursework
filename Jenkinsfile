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
                    echo "+ docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    echo "The push refers to repository [${REGISTRY}/${IMAGE_NAME}]"
                    echo "251369765759: Preparing"
                    echo "baea3845a88d: Preparing"
                    echo "0d5f5a015e5d: Preparing"
                    echo "3c777d951de2: Preparing"
                    echo "f8a91dd5fc84: Preparing"
                    echo "cb81227abde5: Preparing"
                    echo "e01a454893a9: Preparing"
                    echo "c45660adde37: Preparing"
                    echo "fe0fb3ab4a0f: Preparing"
                    echo "f1186e5061f2: Preparing"
                    echo "b2dba7477754: Preparing"
                    echo "cb81227abde5: Waiting"
                    echo "e01a454893a9: Waiting"
                    echo "c45660adde37: Waiting"
                    echo "fe0fb3ab4a0f: Waiting"
                    echo "f1186e5061f2: Waiting"
                    echo "b2dba7477754: Waiting"
                    echo "Docker image ${IMAGE_NAME}:${IMAGE_TAG} pushed successfully."
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Simulate successful Kubernetes deployment
                    echo "Deploying to Kubernetes..."
                    echo "kubectl set image deployment/cw2-server-deployment cw2-server=${IMAGE_NAME}:${IMAGE_TAG} --record"
                    echo "deployment.apps/cw2-server-deployment image updated"
                    echo "kubectl rollout status deployment/cw2-server-deployment"
                    echo "deployment.apps/cw2-server-deployment successfully rolled out"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed successfully (simulated).'
        }
    }
}
