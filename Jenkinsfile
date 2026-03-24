pipeline{
  agent any
  tools{
    maven 'mymav'}
  stages{
    stage('git checkout'){
      steps{
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'dockerhub-creds', url: 'https://github.com/varsha-0411/task6.git']])
        post {
                success {
                    emailext(
                        subject: "checkout Success",
                        body: "checkout completed",
                        to: "varshachowdary411@gmail.com"
                    )
                }
            }
      }
    }
    stage('Build WAR file'){
      steps{
        sh 'mvn clean package'
      }
    }
    stage('Build docker image'){
      steps{
        sh 'docker build -t chittiimg .'
      }
    }
    stage('tag_img'){
      steps{
        sh 'docker tag chittiimg varsha0411/chittiimg:v1'
      }
    }
   stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docke-cred',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }
    stage('docker_push'){
      steps{
        sh 'docker push varsha0411/chittiimg:v1'
      }
    }
    stage('k8s_deployment'){
      steps{
        sh 'kubectl apply -f 6and7.yml'
      }
    }
  }
}
