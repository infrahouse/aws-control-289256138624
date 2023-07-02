module "ih-tf-aws-control-289256138624-admin" {
  source = "./modules/tf-admin"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  gh_identity_provider_arn = aws_iam_openid_connect_provider.github.arn
  repo_name                = "aws-control-289256138624"
  state_bucket             = "infrahouse-aws-control-289256138624"
}
