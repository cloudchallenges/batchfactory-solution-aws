output "ingest_bucket" {
  value = module.ingest_bucket.bucket_id
}

output "ingest_bucket_arn" {
  value = module.ingest_bucket.bucket_arn
}

output "jobs_table" {
  value = module.jobs_table.table_name
}

output "lambda_name" {
  value = module.validator_processor_lambda.lambda_name
}

output "lambda_arn" {
  value = module.validator_processor_lambda.lambda_arn
}
