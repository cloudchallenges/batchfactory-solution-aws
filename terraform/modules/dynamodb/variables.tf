variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "hash_key" {
  description = "Hash key (primary key) name"
  type        = string
  default     = "jobId"
}

variable "ttl_attribute" {
  description = "Attribute name used for TTL (epoch seconds)"
  type        = string
  default     = "ttlEpoch"
}

variable "ttl_enabled" {
  description = "Enable DynamoDB TTL"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the table"
  type        = map(string)
  default     = {}
}
