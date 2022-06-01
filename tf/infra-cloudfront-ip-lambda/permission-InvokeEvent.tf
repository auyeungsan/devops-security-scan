#currency
resource "aws_lambda_permission" "allow_cloudwatch_event_cloudfront_ip" {
  statement_id  = "allow_cloudwatch_event_currency"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.infra_cloudfront_ip_lambda.id
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudfront-ip-schedule.arn
}
