pipeline {
	agent any
	environment {
		DOCKER_TAG = getDockerTag()
	}
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
				sh 'docker build . -t balavpy20/webapp:${DOCKER_TAG}'
			}
		}
		stage('docker_push'){
		    steps {
			withCredentials([usernamePassword(credentialsId:'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
				sh 'docker login -u ${USERNAME} -p ${PASSWORD}'
				sh 'docker push balavpy20/webapp:${DOCKER_TAG}'
			 }
		    }
       		 }
		stage('scan_image'){
			steps {
				aquaMicroscanner imageName: 'balavpy20/webapp', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
			}
		}
		stage('Deployment'){
			steps {
				sh "aws eks --region us-east-1 update-kubeconfig --name eks-cluster"
				sh "chmod +x tagscript.sh"
				sh "bash tagscript.sh ${DOCKER_TAG}"
				sh "kubectl apply -f k8-deployment.yml"
				sh "kubectl get nodes"
				sh "kubectl get deployments"
				sh "kubectl get pod -o wide"
				sh "kubectl get services"
				sh "docker image prune -a -f "
			}
		}
		stage('Status'){
			steps {
				  sh "kubectl rollout status deployments/webapp"
			}
		}
		stage('application_status'){
			steps {
				sh "chmod +x app_status.sh"
				sh "bash app_status.sh"
			}
		}
	}
}

def getDockerTag () {
	def tag = sh script: 'git rev-parse HEAD', returnStdout:true
	return tag
}
