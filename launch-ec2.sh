#!/bin/bash
set -e

echo "🚀 Checking for existing EC2 instance with tag Name=Jenkins-EC2..."

# Check if an EC2 instance with the same tag is already running
RUNNING_INSTANCE=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=Jenkins-EC2" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

if [ -n "$RUNNING_INSTANCE" ]; then
  echo "⚠️  EC2 instance already running: $RUNNING_INSTANCE"
  echo "Skipping creation."
  exit 0
fi

echo "✅ No existing instance found. Launching new EC2 instance..."

aws ec2 run-instances \
  --image-id ami-03bec25d3c8e6cd26 \
  --count 1 \
  --instance-type t2.micro \
  --key-name keypair-pem \
  --security-group-ids sg-0e070a922d373ec66 \
  --subnet-id subnet-070db8be8ec7caf3c \
  --region ap-southeast-1 \
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=Jenkins-EC2}]'

echo "✅ EC2 instance launched successfully."

