locals {
  common_tags = {
  }

  state_buckets = {
    # InfraHouse states
    "infrahouse-aws-control-493370826424" : {
      description : "Terraform state for ci-cd account https://github.com/infrahouse/aws-control-493370826424",
      "repo" : "infrahouse/aws-control-493370826424"
    }
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
