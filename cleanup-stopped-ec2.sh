#!/bin/bash
set -e

echo "🧹 Checking for stopped EC2 instances created by Jenkins..."

# Find stopped instances with the tag Name=Jenkins-EC2
INSTANCE_IDS=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=Jenkins-EC2" "Name=instance-state-name,Values=stopped" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text)

if [ -z "$INSTANCE_IDS" ]; then
  echo "✅ No stopped Jenkins EC2 instances found."
else
  echo "⚠️ Found stopped instances: $INSTANCE_IDS"
  echo "🗑️  Terminating stopped instances..."
  aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
  echo "✅ Termination command sent successfully."
fi
