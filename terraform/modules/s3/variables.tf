variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "force_destroy" {
  description = "Allow bucket to be destroyed even if non-empty (useful for dev)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}

variable "acl" {
  description = "ACL for the bucket"
  type        = string
  default     = "private"
}
