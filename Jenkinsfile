pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				#sh 'mvn test install build'
				sh  'ls -lrt'
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
