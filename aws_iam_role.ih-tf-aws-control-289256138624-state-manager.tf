## Data Sources

module "ih-tf-aws-control-289256138624-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-aws-control-289256138624-state-manager"
  gha_role_arn              = aws_iam_role.ih-tf-aws-control-289256138624-github.arn
  state_bucket              = "infrahouse-aws-control-289256138624"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
