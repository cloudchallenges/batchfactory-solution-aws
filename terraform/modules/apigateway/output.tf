output "api_id" {
  description = "API Gateway ID"
  value       = aws_apigatewayv2_api.api.id
}

output "invoke_url" {
  description = "Base invoke URL for the deployed stage"
  value       = var.stage_name == "$default" ? aws_apigatewayv2_api.api.api_endpoint : "${aws_apigatewayv2_api.api.api_endpoint}/${var.stage_name}"
}

output "api_endpoint" {
  description = "Full API endpoint URL for job status"
  value       = var.stage_name == "$default" ? "${aws_apigatewayv2_api.api.api_endpoint}/jobs" : "${aws_apigatewayv2_api.api.api_endpoint}/${var.stage_name}/jobs"
}

output "execution_arn" {
  description = "Execution ARN for the API (useful for permissions)"
  value       = aws_apigatewayv2_api.api.execution_arn
}
