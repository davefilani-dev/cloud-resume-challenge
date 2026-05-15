#============================================================
# API GATEWAY
# Create public HTTP API endpoint
# for frontend communication
#============================================================

resource "aws_apigatewayv2_api" "visitor_api" {
  name          = "visitor-api"
  protocol_type = "HTTP"
}


#=============================================================
# API GATEWAY INTEGRATION
# Connects API Gateway to Lambda function
#=============================================================

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.visitor_api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.visitor_counter.invoke_arn
  payload_format_version = "2.0"

}

#============================================================
# API ROUTE
# Defines the public routes:
# GET /visitor
#============================================================

resource "aws_apigatewayv2_route" "visitor_route" {
  api_id    = aws_apigatewayv2_api.visitor_api.id
  route_key = "GET /visitor"

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}


#=============================================================
# API DEPLOYMENT STAGE
# Enables automatic deployment of API changes
#==============================================================

resource "aws_apigatewayv2_stage" "prod" {
  api_id = aws_apigatewayv2_api.visitor_api.id


  name = "prod"


  auto_deploy = true

}
