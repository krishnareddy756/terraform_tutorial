resource "aws_s3_bucket" "example" {
  bucket = "krishna-terraform-2026-unique"

  tags = {
    Name = "My S3 Bucket"
  }
}