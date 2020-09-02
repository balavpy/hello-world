pipeline {
	agent any
	environment {
		DOCKER_TAG = getDockerTag()
		IMAGE = 'balavpy20/webapp:\"$DOCKER_TAG\"'
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
				echo 'balavpy20/webapp:\"$DOCKER_TAG\"'
				aquaMicroscanner imageName: 'balavpy20/webapp:\"$DOCKER_TAG\"', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
			}
		}
		stage('Deployment'){
			steps {
				sh 'ls -lrt'
				sh "aws eks --region us-east-1 update-kubeconfig --name eks-cluster"
				sh "chmod +x tagscript.sh"
				sh "ls -lrt; pwd"
				sh "./tagscript.sh ${DOCKER_TAG}"
				sh "kubectl apply -f k8-deployment.yml"
				sh "kubectl get nodes"
				sh "kubectl get deployments"
				sh "kubectl get pod -o wide"
				sh "kubectl get services"
			}
		}
		stage('Status'){
			steps {
				  sh "kubectl rollout status deployments/webapp"
			}
		}
		stage('application_status'){
			steps {
				sh """
					http_url=`kubectl get svc  webapp  | cut -d' ' -f10 | tail -1`
					httpstatus=`curl -s -o /dev/null -w "%{http_code}" ${http_url}:8080/webapp/`
					if [ $httpstatus == '200' ]; then;
					  echo "http status is  '${httpstatus}'- Application is Up & Running"
					else
					  echo "http status is  '${httpstatus}' "
					fi;
				"""
			}
		}
	}
}

def getDockerTag () {
	def tag = sh script: 'git rev-parse HEAD', returnStdout:true
	return tag
}
