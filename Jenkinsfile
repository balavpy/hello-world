pipeline{
    agent any
    stages{
        stage('build stage'){
            steps{
                echo "build maven war"
                sh 'mvn clean install package'
            }
        }
    }
}
