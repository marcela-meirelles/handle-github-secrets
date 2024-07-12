#!/bin/bash

# GitHub repository in the format "owner/repo" or the full URL
REPO="your_github_username/your_repo_name"

# Path to your .env file
ENV_FILE="./.env"

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null
then
	echo "GitHub CLI could not be found. Please install it to proceed."
	exit 1
fi

# Check if the .env file exists
if [ ! -f "$ENV_FILE" ]; then
	echo ".env file does not exist."
	exit 1
fi

# Read each line from the .env file
while IFS= read -r line
do
	# Skip empty lines and lines starting with #
	if [[ -z "$line" || "$line" =~ ^# ]]; then
		continue
	fi

	# Split the line into KEY and VALUE
	IFS='=' read -ra KV <<< "$line"
	KEY="${KV[0]}"
	VALUE="${KV[1]}"

	# Use GitHub CLI to add the secret to the repository
	echo "Adding secret $KEY to $REPO..."
	echo "$VALUE" | gh secret set "$KEY" --repo "$REPO" --body -
done < "$ENV_FILE"

echo "All secrets added successfully."