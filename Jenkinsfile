pipeline{
    agent any 
    stages{
        stage('Checkout'){
            steps {
                git branch: 'main', url: 'https://github.com/Dhusinth/Project2-Three-Tier-AWS.git'
            }
        }

        stage('Docker Build'){
            steps{
                sh 'docker build -t dhusinth123/flaskapp:latest . || true'
            }
        }

        stage('Docker Push'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'my-login-id', 
                                  usernameVariable: 'USER', 
                                  passwordVariable: 'PASS')]) 
                    {
                        sh 'echo $PASS | docker login -u $USER --password-stdin'
                        sh 'docker push dhusinth123/flaskapp:latest'
                     }

            }
        }
        stage('Terraform apply'){
            steps{
                sh 'cd terraform && terraform apply -auto-approve'
            }
        }

        stage('Run Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: 'deploy.yml',
                    inventory: 'hosts.ini',
                    credentialsId: '01',
                    colorized: true,
                    disableHostKeyChecking: true
                )
            }
        }

        stage('Deploy') {
            steps{
                sh 'docker rm -f flaskapp || true'
                sh 'docker run -d -p 5000:5000 --name flaskapp dhusinth123/flaskapp:latest'
            }
        }



    }
}