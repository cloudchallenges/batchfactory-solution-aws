variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "lambda_names" {
  description = "List of Lambda function names to monitor"
  type        = list(string)
}

variable "dlq_name" {
  description = "Name of the Dead Letter Queue"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
