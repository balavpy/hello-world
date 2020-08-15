pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  '/opt/maven/bin/mvn test build install'
			}
		}
		stage('lint'){
			steps {
				echo "test"
			}
		}
		stage('docker_image'){
			steps {
				echo "test"
			}
		}
	}
}
