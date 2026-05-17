#=======================================================
#           VARIABLES
#=======================================================

variable "aws_region" {
  description = "AWS deployment region"
  type        = string


}

variable "bucket_name" {
  description = "s3 bucket name"
  type        = string

}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string


}


variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string


}
