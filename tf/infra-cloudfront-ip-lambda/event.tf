#currency-rate
resource "aws_cloudwatch_event_rule" "cloudfront-ip-schedule" {
  name                = aws_lambda_function.infra_cloudfront_ip_lambda.id
  description         = local.lambda_event_description
  schedule_expression = "cron(0 8 * * ? *)"
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "cloudfront-ip-target" {
  rule      = aws_cloudwatch_event_rule.cloudfront-ip-schedule.name
  target_id = aws_lambda_function.infra_cloudfront_ip_lambda.id
  arn       = aws_lambda_function.infra_cloudfront_ip_lambda.arn
}