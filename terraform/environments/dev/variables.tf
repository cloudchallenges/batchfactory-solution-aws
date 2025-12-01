variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "project_prefix" {
  type    = string
  default = "batchfactory"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "lambda_artifact" {
  description = "Path to local zip artifact for the lambda (used for dev)."
  type        = string
  default     = "../../../artifacts/validator_processor.zip"
}
