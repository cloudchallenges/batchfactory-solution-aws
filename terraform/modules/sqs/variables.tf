variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout for messages"
  type        = number
  default     = 300
}

variable "message_retention_seconds" {
  description = "How long messages are retained in the queue"
  type        = number
  default     = 86400 # 1 day
}

variable "max_receive_count" {
  description = "Number of times a message can be received before being sent to DLQ"
  type        = number
  default     = 3
}

variable "dlq_message_retention_seconds" {
  description = "How long messages are retained in the DLQ"
  type        = number
  default     = 1209600 # 14 days
}

variable "tags" {
  description = "Tags to apply to the queues"
  type        = map(string)
  default     = {}
}
