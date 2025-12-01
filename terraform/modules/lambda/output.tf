output "lambda_arn" {
  description = "ARN of the created Lambda function"
  value       = aws_lambda_function.from_file.arn
}

output "lambda_name" {
  description = "Name of the created Lambda function"
  value       = aws_lambda_function.from_file.function_name
}
