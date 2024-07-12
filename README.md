# GitHub Secrets Management

This project provides scripts to manage GitHub Actions secrets using the GitHub CLI. The main functionalities include uploading secrets from a `.env` file to a GitHub repository and preparing these secrets for use in a GitHub Actions workflow file.

## Prerequisites

- [GitHub CLI](https://cli.github.com/) must be installed and authenticated.

## Scripts

### 1. `.add_env_secrets_to_github_repo.sh`

This script reads a `.env` file, processes each line, and uploads each key-value pair as a GitHub Actions secret.

#### Features:
- Ignores commented lines and empty lines.
- Supports extra `=` signs in the secret value.

#### Usage:

1. Ensure you have a `.env` file in the project directory with your secrets.

3. Change the following line to represent your repo:
```bash
# GitHub repository in the format "owner/repo" or the full URL
REPO="your_github_username/your_repo_name"
```

4. Make the script executable:
Before running the script, you need to make it executable.Use the chmod command to add execution permissions:
```bash
chmod +x add_env_secrets_to_github_repo.sh
```

5. Run the script:

```bash
./add_env_secrets_to_github_repo.sh
```

### 2. `set_secrets_in_yml.sh`

This script reads the same `.env` file and formats the secrets into a list that can be used in a GitHub Actions workflow YAML file.

#### Usage:

1. Ensure you have a `.env` file and a `secrets_list.yml` file in the project directory.

2. Make the script excecutable
```bash
chmod +x set_secrets_in_yml.sh

3. Run the script:

```bash
./set_secrets_in_yml.sh
```

## .env File Format

The `.env` file should contain your secrets in the following format:
```bash
SECRET_KEY=value
ANOTHER_SECRET=another_value
# This is a comment
```

# Example .env File
```bash
DATABASE_URL=mysql://user:password@localhost:3306/dbname
API_KEY=your_api_key
# Commented lines and empty lines are ignored

JWT_SECRET=your_jwt_secret
```

## Example `secrets_list.yml`

The `set_secrets_in_yml.sh` script will generate content that can be included in your GitHub Actions workflow YAML file like this:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Set up secrets
      run: |
        echo "DATABASE_URL=${{ secrets.DATABASE_URL }}" >> $GITHUB_ENV
        echo "API_KEY=${{ secrets.API_KEY }}" >> $GITHUB_ENV
        echo "JWT_SECRET=${{ secrets.JWT_SECRET }}" >> $GITHUB_ENV
```

# License
This project is licensed under the MIT License. See the LICENSE file for details.

# Contributing
Contributions are welcome! Please open an issue or submit a pull request.

# Contact
For any questions or suggestions, please open an issue or contact me directly.

