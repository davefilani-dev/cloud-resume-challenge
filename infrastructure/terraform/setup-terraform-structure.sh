#!/bin/bash

echo "=========================================="
echo " Creating Terraform Project Structure"
echo "=========================================="

#--------------------------------------------
# CREATE RESOURCE SPECIFIC -FILES
#--------------------------------------------

touch iam.tf
touch lambda.tf
touch dynamodb.tf
touch s3.tf
touch apigateway.tf

#------------------------------------------------
# CREATE TERRAFORM MODULE DIRECTORY
#-------------------------------------------------

mkdir -p modules

#---------------------------------------------------
# CREATE LAMBDA SOURCE DIRECTORY 
#--------------------------------------------------

mkdir -p lambda


echo "================================================"
echo " Terraform Structure Created Successfully"
echo "==============================================="

echo ""

tree . || ls


