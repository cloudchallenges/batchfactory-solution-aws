resource "aws_lambda_function" "from_file" {
  function_name    = var.function_name
  role             = var.role_arn
  filename         = var.filename
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  source_code_hash = filebase64sha256(var.filename)
  tags             = var.tags

  environment {
    variables = var.environment
  }
}
