# Roles for CI/CD in the aws-control repo

module "ih-tf-aws-control-990466748045-state-manager" {
  source = "./modules/state-manager-role"
  providers = {
    aws = aws.aws-990466748045-uw1
  }
  name                      = "ih-tf-aws-control-state-manager"
  gha_role_arn              = "arn:aws:iam::990466748045:role/ih-tf-aws-control-github"
  state_bucket              = "infrahouse-aws-control-990466748045"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
