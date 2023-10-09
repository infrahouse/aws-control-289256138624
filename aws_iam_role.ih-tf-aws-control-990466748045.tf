# Roles for CI/CD in the aws-control repo

module "ih-tf-aws-control-990466748045-state-manager" {
  source  = "infrahouse/state-manager/aws"
  version = "~> 0.1"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  name = "ih-tf-aws-control-state-manager"
  assuming_role_arns = [
    "arn:aws:iam::${local.aws_account_id.control}:role/ih-tf-aws-control-github",
    local.me_arn
  ]
  state_bucket              = "infrahouse-aws-control-${local.aws_account_id.control}"
  terraform_locks_table_arn = aws_dynamodb_table.terraform_locks.arn
}
