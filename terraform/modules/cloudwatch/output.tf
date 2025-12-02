output "lambda_errors_alarm_name" {
  description = "Name of the Lambda errors alarm"
  value       = aws_cloudwatch_metric_alarm.lambda_errors.alarm_name
}

output "dlq_alarm_name" {
  description = "Name of the DLQ alarm"
  value       = aws_cloudwatch_metric_alarm.dlq_messages.alarm_name
}
