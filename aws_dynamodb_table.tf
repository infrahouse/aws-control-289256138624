resource "aws_dynamodb_table" "terraform_locks" {
  provider     = aws.aws-289256138624-uw1
  name         = "infrahouse-terraform-state-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
