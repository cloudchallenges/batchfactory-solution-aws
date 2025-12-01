locals {
  prefix = "${var.project_prefix}-${var.env}"
}

# S3 bucket for ingest + processed
module "ingest_bucket" {
  source        = "../../modules/s3"
  bucket_name   = "${local.prefix}-ingest"
  force_destroy = false
  tags = {
    Project = var.project_prefix
    Env     = var.env
  }
}

module "validator_processor_lambda" {
  source        = "../../modules/lambda"
  function_name = "${local.prefix}-vp"
  role_arn      = aws_iam_role.lambda_role.arn
  filename      = var.lambda_artifact # or use s3_bucket + s3_key version of the module
  handler       = "handler.lambda_handler"
  runtime       = "python3.11" # pick supported runtime; python3.11 is safe
  timeout       = 120
  memory_size   = 256

  environment = {
    INGEST_BUCKET    = module.ingest_bucket.bucket_id
    PROCESSED_PREFIX = "processed/"
    JOBS_TABLE       = module.jobs_table.table_name
  }

  tags = {
    Project = var.project_prefix
    Env     = var.env
  }
}

# DynamoDB jobs table
module "jobs_table" {
  source        = "../../modules/dynamodb"
  table_name    = "${local.prefix}-jobs"
  ttl_enabled   = true
  ttl_attribute = "ttlEpoch"
  tags = {
    Project = var.project_prefix
    Env     = var.env
  }
}

# Minimal IAM role for the validator/processor lambda
resource "aws_iam_role" "lambda_role" {
  name = "${local.prefix}-lambda-role"


  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

# Basic logging policy
data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role_policy" "lambda_logging" {
  name   = "${local.prefix}-lambda-logging"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_logging.json
}

# Least-privilege policy for S3 + DynamoDB actions used by the MVP single-lambda
data "aws_iam_policy_document" "lambda_vp_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      module.ingest_bucket.bucket_arn,
      "${module.ingest_bucket.bucket_arn}/*"
    ]
  }

  # Allow the lambda to write and update job records in the DynamoDB jobs table
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:GetItem"
    ]
    resources = [
      module.jobs_table.table_arn
    ]
  }
}

# Attach least-privilege S3 + DynamoDB policy for validator/processor
resource "aws_iam_role_policy" "lambda_vp_policy" {
  name   = "${local.prefix}-lambda-vp-policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_vp_policy.json
}

# Allow S3 to invoke the Lambda for object-created events
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = module.validator_processor_lambda.lambda_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.ingest_bucket.bucket_arn
}

# Configure S3 notifications to invoke the Lambda on CSV uploads
resource "aws_s3_bucket_notification" "ingest_to_lambda" {
  bucket = module.ingest_bucket.bucket_id

  lambda_function {
    lambda_function_arn = module.validator_processor_lambda.lambda_arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix = "uploads/"
    filter_suffix       = ".csv"
  }

  depends_on = [aws_lambda_permission.allow_s3]
}

