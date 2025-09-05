pipeline {
    agent any
    
    stages {
        stage('Hello World') {
            steps {
                echo 'Hello from Jenkins!'
                echo 'Pipeline is running successfully!'
            }
        }
        
        stage('Show Info') {
            steps {
                echo "Build number: ${env.BUILD_NUMBER}"
                echo "Git commit: ${env.GIT_COMMIT}"
                echo "Branch: ${env.GIT_BRANCH}"
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}