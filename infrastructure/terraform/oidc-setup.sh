#!/bin/bash

# =========================================================
# GitHub OIDC + AWS IAM Role Setup Script
# For Terraform GitHub Actions Authentication
# =========================================================

# -----------------------------
# VARIABLES
# -----------------------------

ACCOUNT_ID="178845344404"
GITHUB_USERNAME="davefilani-dev"
REPO_NAME="cloud-resume-challenge"
ROLE_NAME="GitHubActionsTerraformRole"
AWS_REGION="us-east-1"

# -----------------------------
# CREATE OIDC PROVIDER
# -----------------------------

echo "Creating GitHub OIDC Provider..."

aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1

echo "OIDC Provider created successfully."

# -----------------------------
# CREATE TRUST POLICY FILE
# -----------------------------

echo "Creating trust policy..."

cat <<EOF > trust-policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${GITHUB_USERNAME}/${REPO_NAME}:*"
        }
      }
    }
  ]
}
EOF

echo "Trust policy created."

# -----------------------------
# CREATE IAM ROLE
# -----------------------------

echo "Creating IAM role..."

aws iam create-role \
  --role-name ${ROLE_NAME} \
  --assume-role-policy-document file://trust-policy.json

echo "IAM role created successfully."

# -----------------------------
# ATTACH ADMINISTRATOR POLICY
# -----------------------------

echo "Attaching AdministratorAccess policy..."

aws iam attach-role-policy \
  --role-name ${ROLE_NAME} \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

echo "Policy attached successfully."

# -----------------------------
# DISPLAY ROLE ARN
# -----------------------------

echo "Fetching role ARN..."

aws iam get-role \
  --role-name ${ROLE_NAME} \
  --query 'Role.Arn' \
  --output text

echo "OIDC setup completed successfully."


