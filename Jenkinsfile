pipeline {
	agent any
	stages{
		stage('build_war'){
			steps {
				sh  'mvn clean install package'
			}
		}
		
	}
}


