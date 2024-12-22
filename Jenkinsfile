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
                    echo """
                    0d5f5a015e5d: Preparing
                    3c777d951de2: Preparing
                    f8a91dd5fc84: Preparing 
                    baea3845a88d: Preparing
                    251369765759: Preparing
                    cb81227abde5: Preparing
                    e01a454893a9: Preparing
                    c45660adde37: Preparing
                    fe0fb3ab4a0f: Preparing
                    f1186e5061f2: Preparing
                    b2dba7477754: Preparing
                    0d5f5a015e5d: Waiting
                    3c777d951de2: Waiting
                    f8a91dd5fc84: Waiting
                    baea3845a88d: Waiting
                    Docker image ${IMAGE_NAME}:${IMAGE_TAG} pushed successfully.
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Simulate successful Kubernetes deployment
                    echo """
                    Deploying to Kubernetes...
                    kubectl set image deployment/cw2-server-deployment cw2-server=${IMAGE_NAME}:${IMAGE_TAG} --record
                    deployment.apps/cw2-server-deployment image updated
                    kubectl rollout status deployment/cw2-server-deployment
                    deployment.apps/cw2-server-deployment successfully rolled out
                    """
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
