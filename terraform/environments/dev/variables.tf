variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "project_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "batchfactory"
}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "force_destroy" {
  description = "Allow S3 bucket to be destroyed even if non-empty (useful for dev)"
  type        = bool
  default     = true
}

variable "validator_lambda_artifact" {
  description = "Path to local zip artifact for the validator Lambda"
  type        = string
  default     = "../../../artifacts/validator.zip"
}

variable "processor_lambda_artifact" {
  description = "Path to local zip artifact for the processor Lambda"
  type        = string
  default     = "../../../artifacts/processor.zip"
}

variable "api_lambda_artifact" {
  description = "Path to local zip artifact for the API reader Lambda"
  type        = string
  default     = "../../../artifacts/api_reader.zip"
}
