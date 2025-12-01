variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the Lambda function (must be created externally)"
}

variable "filename" {
  type        = string
  description = "Path to a local zip artifact. If provided, Terraform will upload this file to AWS when creating the function."
  default     = ""
}

variable "handler" {
  type    = string
  default = "handler.lambda_handler"
}

variable "runtime" {
  type    = string
  default = "python3.13"
}

variable "timeout" {
  type    = number
  default = 60
}

variable "memory_size" {
  type    = number
  default = 256
}

variable "environment" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
