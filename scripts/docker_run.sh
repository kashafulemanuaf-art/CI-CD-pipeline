#!/bin/bash
set -e

# --- Variables ---
AWS_ACCOUNT_ID=679029767004       # apna AWS account ID daalo
REGION=us-east-1                      # apna region daalo (example: us-east-1)
IMAGE_REPO=$AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/pipeline-test
APP_NAME=app

# --- Login to ECR ---
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com

# --- Get latest image tag from build ---
TAG=$(cat /home/ubuntu/app/imageDetail.txt)

echo "Pulling Docker image: $IMAGE_REPO:$TAG"
docker pull $IMAGE_REPO:$TAG

# --- Stop old container (if running) ---
echo "Stopping old container (if exists)..."
docker stop $APP_NAME || true
docker rm $APP_NAME || true

# --- Run new container ---
echo "Running new container..."
docker run -d --name $APP_NAME -p 8000:8000 $IMAGE_REPO:$TAG

echo "Deployment successful!"
