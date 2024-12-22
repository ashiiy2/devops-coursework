pipeline {
    agent any
    
    // Environment variables and parameters
    environment {
        REGISTRY = 'docker.io'
        IMAGE_NAME = 'ayaqub300/cw2-server'
        // Using BUILD_NUMBER for unique tagging
        IMAGE_TAG = "${BUILD_NUMBER}"
        // Production tag for release
        PROD_TAG = '1.0'
        // Setting up Docker buildkit for better performance
        DOCKER_BUILDKIT = '1'
    }

    // Pipeline options
    options {
        timestamps()  // Add timestamps to console output
        timeout(time: 1, unit: 'HOURS')  // Pipeline timeout
        disableConcurrentBuilds()  // Prevent parallel execution
        ansiColor('xterm')  // Colored output
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    try {
                        git branch: 'master',
                            credentialsId: 'github-credentials',
                            url: 'https://github.com/ashiiy2/devops-coursework.git'
                    } catch (Exception e) {
                        error "Failed to checkout repository: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    try {
                        // Build with both unique and production tags
                        sh """
                            docker build -t ${IMAGE_NAME}:${IMAGE_TAG} \
                                       -t ${IMAGE_NAME}:${PROD_TAG} \
                                       --build-arg BUILDKIT_INLINE_CACHE=1 .
                        """
                    } catch (Exception e) {
                        error "Docker build failed: ${e.getMessage()}"
                    }
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    try {
                        // Run container for testing
                        sh """
                            docker run -d --name test-container -p 8080:8080 ${IMAGE_NAME}:${IMAGE_TAG}
                            sleep 10  # Wait for container to start
                            
                            # Test the endpoint
                            RESPONSE=\$(curl -s http://localhost:8080/)
                            echo "Service Response: \$RESPONSE"
                            
                            # Verify response contains expected string
                            if [[ "\$RESPONSE" != *"DevOps Coursework 2"* ]]; then
                                echo "Unexpected response from service"
                                exit 1
                            fi
                        """
                    } catch (Exception e) {
                        error "Testing failed: ${e.getMessage()}"
                    } finally {
                        // Cleanup test container
                        sh 'docker rm -f test-container || true'
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    try {
                        withCredentials([usernamePassword(
                            credentialsId: 'dockerhub-credentials',
                            usernameVariable: 'DOCKER_USERNAME',
                            passwordVariable: 'DOCKER_PASSWORD'
                        )]) {
                            // Login to Docker Hub securely
                            sh '''
                                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                            '''
                            
                            // Push both tags
                            sh """
                                docker push ${IMAGE_NAME}:${IMAGE_TAG}
                                docker push ${IMAGE_NAME}:${PROD_TAG}
                            """
                        }
                    } catch (Exception e) {
                        error "Failed to push Docker image: ${e.getMessage()}"
                    } finally {
                        // Always logout from Docker
                        sh 'docker logout'
                    }
                }
            }
        }
    }

    post {
        success {
            script {
                // Send success notification
                echo "Pipeline completed successfully!"
                // You can add Slack/Email notifications here
            }
        }
        failure {
            script {
                echo "Pipeline failed!"
                // You can add Slack/Email notifications here
            }
        }
        always {
            script {
                // Cleanup
                try {
                    sh """
                        docker system prune -f
                        docker image rm ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:${PROD_TAG} || true
                    """
                } catch (Exception e) {
                    echo "Cleanup failed: ${e.getMessage()}"
                }
            }
        }
    }
}
