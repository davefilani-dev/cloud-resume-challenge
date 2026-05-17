#!/bin/bash

# =====================================================
# Terraform Remote Backend S3 Bucket Setup Script
# =====================================================

set -e

# -----------------------------
# Configuration
# -----------------------------
AWS_REGION="us-east-1"
ACCOUNT_ID="178845344404"

BUCKET_NAME="dave-cloud-resume-tfstate-${ACCOUNT_ID}"

echo "==============================================="
echo "Creating Terraform Backend Bucket"
echo "==============================================="
echo "Bucket Name : $BUCKET_NAME"
echo "Region      : $AWS_REGION"
echo ""

# -----------------------------
# Create S3 Bucket
# -----------------------------
echo "[+] Creating S3 bucket..."

if [ "$AWS_REGION" = "us-east-1" ]; then
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION"
else
  aws s3api create-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$AWS_REGION" \
    --create-bucket-configuration LocationConstraint="$AWS_REGION"
fi

echo "[+] Bucket created successfully."
echo ""

# -----------------------------
# Enable Versioning
# -----------------------------
echo "[+] Enabling bucket versioning..."

aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled

echo "[+] Versioning enabled."
echo ""

# -----------------------------
# Enable Server-Side Encryption
# -----------------------------
echo "[+] Enabling AES256 encryption..."

aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [
      {
        "ApplyServerSideEncryptionByDefault": {
          "SSEAlgorithm": "AES256"
        }
      }
    ]
  }'

echo "[+] Encryption enabled."
echo ""

# -----------------------------
# Verify Bucket
# -----------------------------
echo "[+] Verifying bucket access..."

aws s3 ls "s3://$BUCKET_NAME"

echo ""
echo "==============================================="
echo "Terraform backend bucket setup complete."
echo "==============================================="
echo ""
echo "Update your Terraform backend block with:"
echo ""
echo "backend \"s3\" {"
echo "  bucket = \"$BUCKET_NAME\""
echo "  key    = \"cloud-resume/terraform.tfstate\""
echo "  region = \"$AWS_REGION\""
echo "  encrypt = true"
echo "}"
echo ""
echo "Then run:"
echo "terraform init -reconfigure"
