## Data Sources

data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        var.gha_role_arn
      ]
    }
  }
}

data "aws_iam_policy_document" "permissions" {
  statement {
    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.state_bucket}"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.state_bucket}/${var.state_key}",
      "arn:aws:s3:::${var.state_bucket}/plans/*"
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
      var.terraform_locks_table_arn
    ]
  }
}

## EOF Data Sources


# IAM role

resource "aws_iam_role" "state-manager" {
  name               = var.name
  description        = "Role to manage a terraform state of a repo"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_policy" "permissions" {
  #  name = "${var.name}-permissions"
  name_prefix = var.name
  policy      = data.aws_iam_policy_document.permissions.json
}

resource "aws_iam_role_policy_attachment" "state-manager" {
  policy_arn = aws_iam_policy.permissions.arn
  role       = aws_iam_role.state-manager.name
}
