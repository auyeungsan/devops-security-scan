resource "aws_security_group" "lambda_scg" {
  name        = local.scg-lambda-function
  description = "scg currency rate"
  vpc_id      = data.aws_vpc.dev.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = local.scg-lambda-function
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/lambda/${local.lambda-function-name}"
  retention_in_days = 1
}

resource "aws_lambda_function" "infra_cloudfront_ip_lambda" {

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  function_name = local.lambda-function-name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  memory_size   = "128"
  timeout       = "15"
  vpc_config {
    subnet_ids= local.subnet_ids
    security_group_ids= [aws_security_group.lambda_scg.id]
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_logs, aws_cloudwatch_log_group.cloudwatch_log_group]
  runtime = "python3.9"

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      last_modified,
      source_code_hash,
    ]
  }

}