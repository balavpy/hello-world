pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  '/opt/maven/bin/mvn test install build'
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
