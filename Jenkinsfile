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
                git branch: 'dev', credentialsId: 'github', url: 'https://github.com/Techwithwesterhof/prod-ready-e2e-jenkins-cicd-pipeline'
            }
        }

    }
}