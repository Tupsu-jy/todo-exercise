pipeline {
    agent any
    environment {
        PATH = "${PATH}:/opt/flutter/bin"
    }
    
    stages {
        stage('GCP Auth') {
            steps {
                withCredentials([file(credentialsId: 'jenkins-deployer', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) {
                    sh '''
                        gcloud auth activate-service-account --key-file="$GOOGLE_APPLICATION_CREDENTIALS"
                        gcloud config set project custom-utility-454621-q9
                        gcloud config set run/region europe-north1
                        gcloud auth configure-docker gcr.io -q
                    '''
                }
            }
        }

        stage('Start Test Stack') {
            steps {
                sh 'docker compose -f docker-compose.test.yml up -d --build'
            }
        }

        stage('Run Tests') {
            steps {
                // Aja Flutter E2E testit suoraan
                // It uses xvfb to run the tests in headless mode
                dir('frontend') {
                    sh 'xvfb-run -a flutter drive --dart-define=WS_URL=ws://localhost:8000/app/ob0ildef0rapadlha0hl --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome'
                }
            }
        }

        // New stage that runs only if 'Run Tests' succeeded (pipeline stops on failure)
        stage('Post-Test Phase') {
            steps {
                sh './gcp-deploy.sh'
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
            sh 'docker compose -f docker-compose.test.yml down || true'
            echo 'Pipeline finished!'
        }
    }
}