pipeline {

    agent any

    environment {

        BACKEND_IMAGE = "dhusinth123/flaskapp:latest"
        FRONTEND_IMAGE = "dhusinth123/frontend:latest"
    }

    stages {

        stage('Checkout Code') {

            steps {

                git branch: 'main',
                url: 'https://github.com/Dhusinth/Project2-Three-Tier-AWS.git'
            }
        }

        stage('Build & Push Docker Images') {

            steps {

                script {

                    docker.withRegistry(
                        'https://index.docker.io/v1/',
                        'dockerhub'
                    ) {

                        // Backend Image

                        def backend = docker.build(
                            "${BACKEND_IMAGE}",
                            "./app"
                        )

                        backend.push()

                        // Frontend Image

                        def frontend = docker.build(
                            "${FRONTEND_IMAGE}",
                            "./frontend"
                        )

                        frontend.push()
                    }
                }
            }
        }

        stage('Deploy Backend') {

            steps {

                ansiblePlaybook(

                    playbook: 'ansible/deploy-backend.yml',

                    inventory: 'ansible/hosts.ini',

                    credentialsId: 'ubuntu',

                    disableHostKeyChecking: true
                )
            }
        }

        stage('Deploy Frontend') {

            steps {

                ansiblePlaybook(

                    playbook: 'ansible/deploy-frontend.yml',

                    inventory: 'ansible/hosts.ini',

                    credentialsId: 'ubuntu',

                    disableHostKeyChecking: true
                )
            }
        }
    }

    post {

        success {

            echo 'Application Deployed Successfully!'
        }

        failure {

            echo 'Deployment Failed!'
        }
    }
}