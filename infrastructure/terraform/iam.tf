#=====================================================
# IAM ROLE FOR LAMBDA
# Allows Lambda service to assume and use
# this execution role
#====================================================

resource "aws_iam_role" "lambda_role" {
  name = "visitor-counter-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

#=========================================================
# IAM POLICY ATTACHMENT
# Grants Lambda permission to write logs into Cloudwatch
#=========================================================

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

#==========================================================
# CUSTOM LAMBDA DYNAMODB POLICY
# Grants Lambda permission to interact with the visitors
# DynamoDB table
#==========================================================

resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name = "lambda-dynamodb-policy"

  policy = jsonencode({
    Version = "2012-10-17"


    Statement = [
      {
        Effect = "Allow"

        Action = [
          "dynamodb:GetItem",
          "dynamodb:UpdateItem",
          "dynamodb:PutItem"

        ]

        Resource = aws_dynamodb_table.visitors.arn
      }
    ]
  })
}


#==========================================================
# ATTACH DYNAMODB POLICY TO LAMBDA ROLE
#=========================================================

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn

}
