output "sns_topic_arn" {
  value = aws_sns_topic.failover.arn
}

output "lambda_arn" {
  value = aws_lambda_function.failover.arn
}
