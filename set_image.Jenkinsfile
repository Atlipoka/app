pipeline {
    environment {
        GIT_REF= sh (returnStdout: true, script: 'git rev-list --tags --max-count=1').trim()
        GIT_TAG= sh (returnStdout: true, script: 'git describe --tags $GIT_REF').trim()
    }
    agent any
    
    stages {
        stage('Login in container registry') {
            steps {
                checkout scmGit(branches: [[name: '**/tags/*']], extensions: [], userRemoteConfigs: [[credentialsId: '0afc43ab-22eb-4854-9a3d-c195533ecd62', refspec: '+refs/tags/*:refs/remotes/origin/tags/*', url: 'git@github.com:Atlipoka/app.git']])
                sh 'cat key.json | docker login --username json_key --password-stdin cr.yandex/crph3q06fo23v71rfm6a'
            }
        }
        stage('Build and push image in container registry') {
            steps {
                sh '''docker build -f nginx.Dockerfile --no-cache -t cr.yandex/crph3q06fo23v71rfm6a/app:$GIT_TAG .
                docker push cr.yandex/crph3q06fo23v71rfm6a/app:$GIT_TAG'''
            }
        }
        stage('Get kubernetes configuration and push new image in applicaton namespace') {
            steps {
                sh '''kubectl set image deployment/nginx nginx=cr.yandex/crph3q06fo23v71rfm6a/app:$GIT_TAG'''
            }
        }
    }
}
