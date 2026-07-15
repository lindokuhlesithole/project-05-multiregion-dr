resource "aws_sns_topic" "failover" {
  name = "${var.app_name}-failover-topic"

  tags = { Name = "${var.app_name}-failover-topic" }
}

resource "aws_iam_role" "failover" {
  name = "${var.app_name}-failover-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })

  tags = { Name = "${var.app_name}-failover-lambda-role" }
}

resource "aws_iam_role_policy_attachment" "failover" {
  role       = aws_iam_role.failover.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "failover" {
  function_name = "${var.app_name}-failover"
  role          = aws_iam_role.failover.arn
  handler       = "index.handler"
  runtime       = "python3.11"

  filename         = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256

  tags = { Name = "${var.app_name}-failover" }

  depends_on = [aws_iam_role_policy_attachment.failover]
}

data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/lambda.zip"

  source {
    content  = <<-EOF
import json
import boto3

def handler(event, context):
    print("Failover triggered")
    return {"statusCode": 200, "body": json.dumps("Failover executed")}
EOF
    filename = "index.py"
  }
}
