#===========================================================
# LAMBDA FUNCTION
# Serverless backend responsible for:
# - retrieving visitor count
# - incrementing count
# - updating DynamoDB
# - returning updated value
#===========================================================

resource "aws_lambda_function" "visitor_counter" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"

  # Deployment package containing Lambda code
  filename = "function.zip"

  # Detects code changes automatically
  source_code_hash = filebase64sha256("function.zip")

  # Environment variable passed into Lambda

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.visitors.name
    }
  }
}

#===============================================================
# LAMBDA INVOCATION PERMISSION
# Grants API Gateway permission to invoke the lambda function
#================================================================

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.visitor_counter.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.visitor_api.execution_arn}/*/*"
}
