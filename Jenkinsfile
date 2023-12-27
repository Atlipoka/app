pipeline {
    agent any

    stages {
        stage('Get docker version') {
            steps {
                sh 'docker --version'
            }
        }
        stage('Login in container registry') {
            steps {
                sh 'cat key.json | docker login --username json_key --password-stdin cr.yandex/crph3q06fo23v71rfm6a'
            }
        }
        stage('Build and push image in container registry ') {
            steps {
                sh '''docker build -f nginx.Dockerfile --no-cache -t cr.yandex/crph3q06fo23v71rfm6a/app:1.0.0 .
                docker push cr.yandex/crph3q06fo23v71rfm6a/app:1.0.0'''
            }
        }
        stage('react on git tag') {
            when {
                buildingTag()
            }
            steps {
                sh 'git tag --list | head -1'
            }
        }
    }
}
