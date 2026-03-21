resource "aws_dynamodb_table" "remote_infra" {
  name           = "remote-infra-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "remote-infra-table"
    Environment = "Dev"
  }
}