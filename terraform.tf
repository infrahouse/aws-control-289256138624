terraform {
  backend "s3" {
    bucket = "infrahouse-aws-control-289256138624"
    key    = "terraform.tfstate"
    region = "us-west-1"
    assume_role = {
      role_arn = "arn:aws:iam::289256138624:role/ih-tf-aws-control-289256138624-state-manager"
    }
    dynamodb_table = "infrahouse-aws-control-289256138624-polite-grubworm"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
