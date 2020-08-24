pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  'mvn clean install package'
			}
		}
		stage('lint_checks'){
			steps {
				sh  'hadolint Dockerfile'
			}
		 }
		stage('docker_build'){
			steps {
				sh 'docker build -t balavpy20/webapp:latest .'
			}
		}
		stage('scan_image'){
			steps {
				aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
			}
		}
		stage('docker_push'){
		    steps {
			withCredentials([usernameColonPassword(credentialsId:'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
			    sh 'docker login -u $USERNAME -p $PASSWORD'
			     sh 'docker push balavpy20/webapp:latest'
			 }
		    }
       		 }
	}
}


