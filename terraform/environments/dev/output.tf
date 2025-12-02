output "ingest_bucket" {
  description = "S3 bucket for uploading CSV files"
  value       = module.ingest_bucket.bucket_id
}

output "jobs_table" {
  description = "DynamoDB table for job records"
  value       = module.jobs_table.table_name
}

output "api_endpoint" {
  description = "API Gateway endpoint for job status"
  value       = module.api_gateway.api_endpoint
}
