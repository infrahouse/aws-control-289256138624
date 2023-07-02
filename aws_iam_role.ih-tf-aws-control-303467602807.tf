# Roles for CI/CD in the aws-control-303467602807 repo

module "ih-tf-aws-control-303467602807-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name                      = "ih-tf-aws-control-303467602807-state-manager"
  gha_role_arn              = "arn:aws:iam::303467602807:role/ih-tf-aws-control-303467602807-github"
  state_bucket              = "infrahouse-aws-control-303467602807"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
