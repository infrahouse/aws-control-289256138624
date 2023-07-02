## Data Sources

data "aws_iam_policy_document" "ih-tf-aws-control-289256138624-state-manager-assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        aws_iam_role.ih-tf-aws-control-289256138624-admin.arn
      ]
    }
  }
}

data "aws_iam_policy_document" "ih-tf-aws-control-289256138624-state-manager-permissions" {
  statement {
    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::infrahouse-aws-control-289256138624"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::infrahouse-aws-control-289256138624/terraform.tfstate"
    ]
  }
  statement {
    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      aws_dynamodb_table.terraform_locks.arn
    ]
  }
}

## EOF Data Sources


# IAM role

resource "aws_iam_role" "ih-tf-aws-control-289256138624-state-manager" {
  provider           = aws.aws-289256138624-uw1
  name               = "ih-tf-aws-control-289256138624-state-manager"
  description        = "Role to manage state of the repo aws-control-289256138624"
  assume_role_policy = data.aws_iam_policy_document.ih-tf-aws-control-289256138624-state-manager-assume.json
}

resource "aws_iam_policy" "ih-tf-aws-control-289256138624-state-manager-permissions" {
  provider = aws.aws-289256138624-uw1
  policy   = data.aws_iam_policy_document.ih-tf-aws-control-289256138624-state-manager-permissions.json
}

resource "aws_iam_role_policy_attachment" "ih-tf-aws-control-289256138624-state-manager" {
  provider   = aws.aws-289256138624-uw1
  policy_arn = aws_iam_policy.ih-tf-aws-control-289256138624-state-manager-permissions.arn
  role       = aws_iam_role.ih-tf-aws-control-289256138624-state-manager.name
}
