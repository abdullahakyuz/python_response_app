pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "aakyuz1/etl-app"
        KUBECONFIG = credentials('kubeconfig') // Kubernetes erişim bilgileri
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        docker.image(DOCKER_IMAGE).push('latest')
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Kubernetes'e dağıtım yap
                    sh "kubectl apply -f /k8s"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
