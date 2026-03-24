pipeline {
    agent any

    tools {
        maven 'mymav'
    }

    stages {

        stage('Git Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[credentialsId: 'dockerhub-creds', url: 'https://github.com/varsha-0411/task6.git']]
                )
            }
            post {
                success {
                    emailext(
                        subject: "Checkout Success",
                        body: "Checkout completed",
                        to: "varshachowdary411@gmail.com"
                    )
                }
            }
        }

        stage('Build WAR file') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t chittiimg .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh 'docker tag chittiimg varsha0411/chittiimg:v1'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push varsha0411/chittiimg:v1'
            }
        }

        stage('K8s Deployment') {
            steps {
              withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                sh '''
                export KUBECONFIG=$KUBECONFIG
                kubectl get nodes
                kubectl apply -f 6and7.yml
                '''
        }
    }
}

    } 
} 
