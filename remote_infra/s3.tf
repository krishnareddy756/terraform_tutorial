resource "aws_s3_bucket" "remote_infra" {
  bucket = "remote-infra"
  acl    = "private"

  tags = {
    Name        = "remote-infra"
    Environment = "Dev"
  }
}