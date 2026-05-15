#!/bin/bash

# =========================================================
# CLOUDFRONT DISTRIBUTION CLEANUP SCRIPT
# ---------------------------------------------------------
# This script:
# 1. Downloads existing distribution config
# 2. Disables the distribution
# 3. Waits for deployment
# 4. Retrieves updated ETag
# 5. Deletes the distribution
#
# NOTE:
# - Replace DISTRIBUTION_ID with your OLD manual distribution ID
# - Do NOT use this on Terraform-managed distributions
# =========================================================

# -----------------------------
# SET YOUR DISTRIBUTION ID HERE
# -----------------------------
DISTRIBUTION_ID=E3FDSVAGXIYBCH

echo "========================================="
echo "STEP 1: Retrieving distribution config..."
echo "========================================="

aws cloudfront get-distribution-config \
  --id $DISTRIBUTION_ID \
  > distribution-config.json

# -------------------------------------------
# EXTRACT CURRENT ETAG FROM DOWNLOADED CONFIG
# -------------------------------------------
ETAG=$(jq -r '.ETag' distribution-config.json)

echo "Current ETag: $ETAG"

# =========================================================
# STEP 2: PREPARE CLEAN CONFIG FILE
# Removes outer ETag wrapper and keeps only
# DistributionConfig object
# =========================================================

jq '.DistributionConfig' distribution-config.json \
  > clean-config.json

# =========================================================
# STEP 3: DISABLE DISTRIBUTION
# =========================================================

echo "========================================="
echo "STEP 2: Disabling distribution..."
echo "========================================="

jq '.Enabled=false' clean-config.json \
  > disabled-config.json

aws cloudfront update-distribution \
  --id $DISTRIBUTION_ID \
  --if-match $ETAG \
  --distribution-config file://disabled-config.json

echo "========================================="
echo "Distribution disabling initiated..."
echo "Waiting for deployment completion..."
echo "========================================="

# =========================================================
# STEP 4: WAIT UNTIL DEPLOYMENT COMPLETES
# =========================================================

aws cloudfront wait distribution-deployed \
  --id $DISTRIBUTION_ID

echo "Distribution successfully disabled."

# =========================================================
# STEP 5: GET NEW ETAG
# CloudFront generates a new ETag after updates
# =========================================================

echo "========================================="
echo "STEP 3: Retrieving updated ETag..."
echo "========================================="

aws cloudfront get-distribution-config \
  --id $DISTRIBUTION_ID \
  > updated-config.json

NEW_ETAG=$(jq -r '.ETag' updated-config.json)

echo "New ETag: $NEW_ETAG"

# =========================================================
# STEP 6: DELETE DISTRIBUTION
# =========================================================

echo "========================================="
echo "STEP 4: Deleting distribution..."
echo "========================================="

aws cloudfront delete-distribution \
  --id $DISTRIBUTION_ID \
  --if-match $NEW_ETAG

echo "========================================="
echo "CloudFront distribution deleted."
echo "=========================================
