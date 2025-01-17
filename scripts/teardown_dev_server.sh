#!/bin/bash

set -e

# Directory paths
SCRIPT_DIR=$(dirname $(realpath "$0"))
STATE_DIR="$(dirname $SCRIPT_DIR)/state"

# Function to display usage
usage() {
  echo "Usage: $0 dev server must be deployed."
  exit 1
}

# Check if .state file exists
echo "Collecting .state file"
STATE_PATH="$STATE_DIR/dev-server-$(hostname)/dev-server-$(hostname).state"
if [ ! -f "$STATE_PATH" ]; then
  echo "dev-server-$(hostname).state not found!"
  usage
  exit 1
fi
source $STATE_PATH

# Check if mandatory arguments are provided
if [ -z "$DEPLOYMENT_NAME" ] || [ -z "$REGION" ]; then
  usage
fi

# Create CloudFormation stack
echo "Deleting deployment stack"
aws cloudformation delete-stack \
  --stack-name "$DEPLOYMENT_NAME" \
  --region "$REGION"

# Wait for the stack to be deleted
echo "Waiting for stack to be deleted"
aws cloudformation wait stack-delete-complete --stack-name "$DEPLOYMENT_NAME" --region "$REGION"


# Delete .state file
echo "Cleaning up state files at: $STATE_DIR/$DEPLOYMENT_NAME"
rm -r "$STATE_DIR/$DEPLOYMENT_NAME"