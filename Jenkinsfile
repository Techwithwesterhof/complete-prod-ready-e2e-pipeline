pipeline{
    agent{
        label "jenkins-cicd-agent"    
        }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    
    stages{
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }

        }
    
        stage("Checkout from SCM"){
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Techwithwesterhof/complete-prod-ready-e2e-pipeline'
            }

        }

        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

        }

        stage("Test Application"){
            steps {
                sh "mvn test"
            }

        }

        stage("Sonarqube Analysis") {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'prod-ready-cicd-sonartoken') {
                        sh "mvn sonar:sonar"
                    }
                }
            }

        }

        stage("Quality Gate") {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'prod-ready-cicd-sonartoken'
                }
            }

        }
    }

}