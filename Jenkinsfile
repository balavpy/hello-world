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
				  sh "aws eks --region us-east-1 update-kubeconfig --name eks-cluster"
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
				sh 'http_url=`kubectl get svc  webapp  | cut -d' ' -f10 | tail -1`'
				sh 'httpstatus=`curl -s -o /dev/null -w \"%{http_code}\" \"${http_url}\":8080/webapp/`'
			}
		}
	}
}
