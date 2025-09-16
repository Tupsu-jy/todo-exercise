pipeline {
    agent any
    environment {
        PATH = "${PATH}:/opt/flutter/bin"
    }
    
    stages {

        stage('Build Docker Images') {
            steps {
                sh 'docker compose -f docker-compose.test.yml build'
            }
        }

        stage('Run Tests') {
            steps {
                // Aja Flutter E2E testit suoraan
                dir('frontend') {
                    sh 'xvfb-run -a flutter drive --dart-define=WS_URL=ws://localhost:8000/app/ob0ildef0rapadlha0hl --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome'
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh 'docker compose -f docker-compose.test.yml down'
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}