pipeline {

    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        SSH_CREDENTIALS       = 'ubuntu'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                url: 'https://github.com/Dhusinth/Project2-Three-Tier-AWS.git'
            }
        }

        stage('Build & Push Backend Image') {
            steps {

                script {

                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {

                        sh '''
                            docker build --no-cache -t dhusinth123/flaskapp:latest ./app
                            docker push dhusinth123/flaskapp:latest
                        '''
                    }
                }
            }
        }

        stage('Build & Push Frontend Image') {
            steps {

                script {

                    docker.withRegistry('', DOCKERHUB_CREDENTIALS) {

                        sh '''
                            docker build --no-cache -t dhusinth123/frontend:latest ./frontend
                            docker push dhusinth123/frontend:latest
                        '''
                    }
                }
            }
        }

        stage('Deploy Backend') {
            steps {

                sshagent(credentials: [SSH_CREDENTIALS]) {

                    sh '''
                        ansible-playbook \
                        -i ansible/hosts.ini \
                        ansible/deploy-backend.yml
                    '''
                }
            }
        }

        stage('Deploy Frontend') {
            steps {

                sshagent(credentials: [SSH_CREDENTIALS]) {

                    sh '''
                        ansible-playbook \
                        -i ansible/hosts.ini \
                        ansible/deploy-frontend.yml
                    '''
                }
            }
        }
    }

    post {

        success {
            echo 'Deployment Successful!'
        }

        failure {
            echo 'Deployment Failed!'
        }
    }
}