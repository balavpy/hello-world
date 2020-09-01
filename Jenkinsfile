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
		stage('docker_push'){
		    steps {
			withCredentials([usernamePassword(credentialsId:'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
				sh 'docker login -u ${USERNAME} -p ${PASSWORD}'
				sh 'docker push balavpy20/webapp:latest'
			 }
		    }
       		 }
		stage('scan_image'){
			steps {
				aquaMicroscanner imageName: 'balavpy20/webapp:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
			}
		}
		stage('Deployment'){
			steps {
				withAWS(credentials: 'static-id', region: 'ap-east-1') {
                      			sh "aws eks --region ap-south-1 update-kubeconfig --name eks-cluster"
				}
			}
		}
	}
}

