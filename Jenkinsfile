def BRANCH
pipeline {
    agent any
    environment {
        PROJECT_ID = '<project-id>'
        CLUSTER_NAME = '<cluster-name>'
        LOCATION = '<zone>'
        CREDENTIALS_ID = '<credential-id>'
	NAMESPACE = 'default'
    }

    tools {
        maven "maven3"
    }

    stages {
        stage('Clone') {
            steps {
                // Get the code from a GitHub repository
		// cleanWs()
                git 'https://github.com/pranavdhopey/springboot-helloworld-jar.git'
		script {
                    BRANCH = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                    echo "${BRANCH}"
                }
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
                   dockerImage = docker.build("asia.gcr.io/${env.PROJECT_ID}/pranavweb/springapp:${env.BUILD_ID}")
                }
            }
        }

	stage('Pushing image') {
            steps {
	        script {
                    withDockerRegistry(credentialsId: 'gcr:searce-playground', url: 'https://asia.gcr.io') {
    	                dockerImage.push("${env.BUILD_ID}")
		    }	
                } 
            }
        }

	stage('Deploy to GKE') {
            steps {
	        sh "sed -i 's/latest/${env.BUILD_ID}/g' Manifest/deployment.yaml"

		// sh "sed -i '/namespace:/ s/default/${NAMESPACE}/g' Manifest/deployment.yaml"
		// sh "sed -i '/namespace:/ s/default/${NAMESPACE}/g' Manifest/service.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, zone: env.LOCATION, manifestPattern: 'Manifest/', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }     
        }

    }
}
