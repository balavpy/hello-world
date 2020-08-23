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
				sh 'docker build -t webapp .'
			}
		 }
		stage('docker_image'){
			steps {
				echo "test"
			}
		}
	}
}
