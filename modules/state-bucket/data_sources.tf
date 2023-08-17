data "terraform_remote_state" "state" {
  backend = "s3"
  config = {
    bucket = aws_s3_bucket.state-bucket.bucket
    key    = "terraform.tfstate"
    region = aws_s3_bucket.state-bucket.region
  }
}
