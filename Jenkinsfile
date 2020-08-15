pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  '/opt/maven/bin/mvn clean install package'
			}
		}
		stage('lint'){
			steps {
				sh 'sudo docker build -t webapp .'
			}
		 }
		stage('docker_image'){
			steps {
				echo "test"
			}
		}
	}
}
