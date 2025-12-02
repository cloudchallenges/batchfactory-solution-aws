# HTTP API (v2)
resource "aws_apigatewayv2_api" "api" {
  name          = "${var.name_prefix}-api"
  protocol_type = "HTTP"
}

# Lambda integration - connects API to Lambda function
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.api.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# Route: GET /jobs/{id} - retrieves job status by ID
resource "aws_apigatewayv2_route" "get_job" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /jobs/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# Deployment stage (auto-deploys on changes)
resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = var.stage_name
  auto_deploy = true
}

# Allow API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "allow_apigw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/${var.stage_name}/GET/jobs/*"
}
