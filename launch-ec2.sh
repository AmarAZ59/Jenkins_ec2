#!/bin/bash
set -e

echo "Launching EC2 instance..."

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

