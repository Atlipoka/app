pipeline {
    agent any

    stages {
        stage('Login in container registry') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [cleanAfterCheckout(deleteUntrackedNestedRepositories: true)], userRemoteConfigs: [[credentialsId: '0afc43ab-22eb-4854-9a3d-c195533ecd62', url: 'git@github.com:Atlipoka/app.git']])
                sh 'cat key.json | docker login --username json_key --password-stdin cr.yandex/crph3q06fo23v71rfm6a'
            }
        stage('Build and push image in container registry') {
            steps {
                sh '''docker build -f nginx.Dockerfile --no-cache -t cr.yandex/crph3q06fo23v71rfm6a/app .
                docker push cr.yandex/crph3q06fo23v71rfm6a/app'''
            }
        }
    }
}
