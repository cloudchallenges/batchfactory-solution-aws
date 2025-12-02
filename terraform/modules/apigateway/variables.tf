variable "name_prefix" {
  description = "Prefix for naming the API resources"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of the Lambda function to integrate"
  type        = string
}

variable "lambda_name" {
  description = "Name of the Lambda function (used for permission)"
  type        = string
}

variable "stage_name" {
  description = "API Gateway deployment stage name"
  type        = string
  default     = "dev"
}
