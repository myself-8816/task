pipeline {
    agent any

    tools {
        maven 'maven'
    }

    stages {

        stage('Git Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[credentialsId: 'dockerhub-creds', url: 'https://github.com/myself-8816/task.git']]
                )
            }
            post {
                success {
                    emailext(
                        subject: "Checkout Success",
                        body: "Checkout completed",
                        to: "pavansai131299@gmail.com"
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
                sh 'docker build -t pavan1img .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh 'docker tag pavan1img pavansai33/pavan1img:v21'
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
                sh 'docker push pavansai33/pavan1img:v21'
            }
        }

        stage('K8s Deployment') {
            steps {
              withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                sh '''
                export KUBECONFIG=$KUBECONFIG
                kubectl get nodes
                kubectl apply -f saipavan.yml
                '''
        }
    }
}

    } 
} 
