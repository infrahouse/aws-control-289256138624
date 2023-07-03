module "github-connector" {
  source = "github.com/infrahouse/terraform-aws-gh-identity-provider"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
}
