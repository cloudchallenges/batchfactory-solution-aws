# Alarm: Lambda Errors - triggers when any Lambda function has errors
resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${var.name_prefix}-lambda-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 0
  alarm_description   = "Lambda function errors detected"
  treat_missing_data  = "notBreaching"

  metric_query {
    id          = "errors"
    expression  = "SUM(METRICS())"
    label       = "Total Errors"
    return_data = true
  }

  dynamic "metric_query" {
    for_each = var.lambda_names
    content {
      id = "e${metric_query.key}"
      metric {
        metric_name = "Errors"
        namespace   = "AWS/Lambda"
        period      = 300
        stat        = "Sum"
        dimensions = {
          FunctionName = metric_query.value
        }
      }
    }
  }

  tags = var.tags
}

# Alarm: DLQ Messages - triggers when messages land in Dead Letter Queue
resource "aws_cloudwatch_metric_alarm" "dlq_messages" {
  alarm_name          = "${var.name_prefix}-dlq-not-empty"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = 300
  statistic           = "Maximum"
  threshold           = 0
  alarm_description   = "Messages in Dead Letter Queue - check for processing failures"
  treat_missing_data  = "notBreaching"

  dimensions = {
    QueueName = var.dlq_name
  }

  tags = var.tags
}
