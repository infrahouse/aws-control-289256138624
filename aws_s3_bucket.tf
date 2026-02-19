locals {
  common_tags = {
  }

  state_buckets = {
    # InfraHouse states
    "infrahouse-website-infra" : {
      description : "Terraform state for https://github.com/infrahouse/infrahouse-website-infra",
      "repo" : "infrahouse/infrahouse-website-infra"
    }

  }
}

module "buckets" {
  source  = "infrahouse/state-bucket/aws"
  version = "~> 2.0"
  providers = {
    aws = aws.aws-289256138624-uw1
  }
  for_each = local.state_buckets
  bucket   = each.key
  tags = merge(
    local.common_tags,
    {
      "description" : each.value["description"],
      "repo" : each.value["repo"]
    }
  )
}
