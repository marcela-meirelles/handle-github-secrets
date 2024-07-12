# Path to the .env and workflow.yml files
ENV_FILE=".env"
WORKFLOW_FILE="secrets_list.yml"

# Read each line in the .env file
while IFS= read -r line; do
    # Skip empty lines and lines starting with #
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        continue
    fi

    # Extract key and value
    IFS='=' read -r key value <<< "$line"

    # Format the key as required and append it to the workflow.yml file
    echo "  $key: \${{ secrets.$key }}" >> "$WORKFLOW_FILE"
done < "$ENV_FILE"

echo "Secrets keys have been added to $WORKFLOW_FILE."