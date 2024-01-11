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
                kubeconfig(caCertificate: '''-----BEGIN CERTIFICATE-----
MIIC5zCCAc+gAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTI0MDExMTEzMzc0MFoXDTM0MDEwODEzMzc0MFowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL5O
QPm9DCnzTBI6It5PBh7tOJaUk+AhWLsbhIsyrMUREvD+P/wWVjX8A+aYHV+yK3GR
Brls8q1ph3s6A2KkZU47TKCnl2Cu64KLgDG01+KkaVbJHn6I50hf9Zjf/f4P3H6/
Shmu9UQaiN5bBIjFPTnr0GAV8kCbtcDKrDrYE+zhORsUTaUvj1ZL/r4va6XBwHX2
0sJvuWyfVchZob7ouROZhBfdYBWjyJFfZxwWCA8HX1RVs+2GaSFIVC/ow7dX6LyG
bYHiUkle501hAe/x5xPkGUq0b76m85AvjbfEobq4yrSNpfAPT5rR7eHe2lZDtEMv
6QsdBVeWzANnqdEfOfcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wHQYDVR0OBBYEFF0Fy4i7p0GTlyd7ipok5DyPgeX2MA0GCSqGSIb3
DQEBCwUAA4IBAQBp9PnjSYKX7Fr2SFxz1VNJT+KQbYPdEBtnzNwKNzI9/MUHliV+
4PuMn0z+TjRr6B3e4rOrbKV9Rb/9lKS9qHw+j8U/K86B43VlMLGy0uzH038JLKDK
VnAxq0ULDq/JIF/+WBpiAkLOQDX2/HH37MMmK6HKwgfm3E3/cjitN32iFKlpg+k/
XtoPtvtSVFL5C8tRf7yHRA30irtqW7tUETBAdBo1CQw779qEKo6bBKM8xbD2kId/
H2Phhw2ua6JdZ40oy7LoJsZ7lA2Y0QaM2+brbXof5q1WOLwFFxcY+yKHh4IZNNlO
CzEBC7y0Oa2x27t2EoFELtEeGYsR38fgx/cS
-----END CERTIFICATE-----''', credentialsId: '38108245-bf9a-4189-ab74-c23380c93d0c', serverUrl: 'https://158.160.141.102') {
                    sh 'kubectl set image deployment.apps/nginx -n application nginx=cr.yandex/crph3q06fo23v71rfm6a/app:$GIT_TAG'
                }
            }
        }
    }
}
