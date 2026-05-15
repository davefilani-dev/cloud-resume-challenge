#=======================================================
#           VARIABLES
#=======================================================

variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "us-east-1"

}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string

}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "visitors"

}


variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "visitor-counter"

}
