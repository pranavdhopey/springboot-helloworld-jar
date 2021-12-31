pipeline {
    agent any

    tools {
        maven "maven3"
    }

    stages {
        stage('Clone') {
            steps {
                // Get the code from a GitHub repository
                git 'https://github.com/pranavdhopey/springboot-helloworld-jar.git'
            }
        }
		
        stage('Build') {
            steps {		
	        // Run Maven on a agent.
                sh "mvn clean install"
            }
        }
		
	stage('Building image') {
            steps {
                script {
                   dockerImage = docker.build("asia.gcr.io/my-project/pranavweb/springapp:${env.BUILD_ID}")
                }
            }
        }

	stage('Pushing image') {
            steps {
	        script {
                    withDockerRegistry(credentialsId: 'gcr:my-project', url: 'https://asia.gcr.io') {
    	                dockerImage.push("${env.BUILD_ID}")
		    }	
                } 
            }
        }
    }
}
