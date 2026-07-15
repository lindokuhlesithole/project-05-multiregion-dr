resource "aws_dynamodb_table" "sessions" {
  name         = "${var.app_name}-sessions"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "sessionId"

  attribute {
    name = "sessionId"
    type = "S"
  }

  tags = { Name = "${var.app_name}-sessions" }
}
