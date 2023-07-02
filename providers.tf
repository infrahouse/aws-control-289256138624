provider "aws" {
  alias  = "aws-289256138624-uw1"
  region = "us-west-1"
  assume_role {
    role_arn = "arn:aws:iam::289256138624:role/ih-tf-aws-control-289256138624-admin"
  }
  default_tags {
    tags = {
      "created_by" : "infrahouse/aws-control-289256138624" # GitHub repository that created a resource
    }
  }
}
