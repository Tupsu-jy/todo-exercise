#!/bin/bash

# Configuration
PROJECT_ID="custom-utility-454621-q9"
REGION="europe-north1"
BACKEND_URL="://php-app-348849534274.europe-north1.run.app"

# Create timestamp tag
VERSION=$(date +%Y%m%d_%H%M%S)

echo "Deploying backend..."
cd api
docker build -t gcr.io/${PROJECT_ID}/php-app:${VERSION} .
docker push gcr.io/${PROJECT_ID}/php-app:${VERSION}
#gcloud run deploy php-app \
#  --image gcr.io/${PROJECT_ID}/php-app:latest \
#  --platform managed \
#  --region ${REGION} \
#  --allow-unauthenticated \
#  --port 8000

echo "Deploying frontend..."
cd ../frontend
docker build -t gcr.io/${PROJECT_ID}/flutter-app:${VERSION} \
  --build-arg API_URL=https${BACKEND_URL}/api \
  --build-arg WS_URL=wss${BACKEND_URL}/app/ob0ildef0rapadlha0hl .
docker push gcr.io/${PROJECT_ID}/flutter-app:${VERSION}
#gcloud run deploy flutter-app \
#  --image gcr.io/${PROJECT_ID}/flutter-app:latest \
#  --platform managed \
#  --region ${REGION} \
#  --allow-unauthenticated

echo "Done!"