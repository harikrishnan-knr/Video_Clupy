pipeline {

    agent any

    tools {
        maven 'Maven'
    }

    stages {
      agent {
        lable : build
      }
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'mvn test'
            }

            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {

                    sh '''
                        mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
                        -Dsonar.projectKey=Video_Clupy \
                        -Dsonar.projectName='Video_Clupy' \
                        -Dsonar.host.url=http://172.31.3.247:9000 \
                        -Dsonar.token=$sonar-token
                    '''
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                sh 'mvn deploy -DskipTests'
            }
        }
    }
}

mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar \
  -Dsonar.projectKey=Video_Clupy \
  -Dsonar.projectName='Video_Clupy' \
  -Dsonar.host.url=http://54.169.243.130:9000 \
  -Dsonar.token=$sonar-token
