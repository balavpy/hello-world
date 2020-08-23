pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  'mvn clean install package'
			}
		}
		stage('lint'){
			steps {
				sh  'sudo docker build -t test .'
			}
		 }
		stage('docker_image'){
			steps {
				echo "test"
			}
		}
	}
}
