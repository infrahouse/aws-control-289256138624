locals {
  common_tags = {
  }

  state_buckets = {
    # InfraHouse states
    "infrahouse-aws-control-990466748045" : {
      description : "Terraform state for the main AWS account 990466748045 https://github.com/infrahouse/aws-control",
      "repo" : "infrahouse/aws-control"
    }
    "infrahouse-aws-control-289256138624" : {
      description : "Terraform state for terraform-control account https://github.com/infrahouse/aws-control-289256138624",
      "repo" : "infrahouse/aws-control-289256138624"
    }
    "infrahouse-aws-control-303467602807" : {
      description : "Terraform state for ci-cd account https://github.com/infrahouse/aws-control-303467602807",
      "repo" : "infrahouse/aws-control-303467602807"
    }
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
  version = "~> 1.0"
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
