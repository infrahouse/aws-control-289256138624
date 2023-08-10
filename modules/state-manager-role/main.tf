## Data Sources

data "aws_iam_policy_document" "assume" {
  statement {
    sid     = "000"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::990466748045:user/aleks",
        var.assuming_role_arn
      ]
    }
  }
}

locals {
  state_resources = [
    "arn:aws:s3:::${var.state_bucket}/${var.state_key}",
    "arn:aws:s3:::${var.state_bucket}/plans/*",
    "arn:aws:s3:::${var.state_bucket}/*.zip"
  ]
}
data "aws_iam_policy_document" "permissions_ro" {
  statement {
    actions = ["s3:ListBucket"]
    resources = [
      "arn:aws:s3:::${var.state_bucket}"
    ]
  }
  statement {
    actions = [
      "s3:GetObject",
    ]
    resources = local.state_resources
  }
}

data "aws_iam_policy_document" "permissions_rw" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = local.state_resources
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

resource "aws_iam_policy" "permissions_ro" {
  #  name = "${var.name}-permissions"
  name_prefix = "${var.name}-ro"
  policy      = data.aws_iam_policy_document.permissions_ro.json
}

resource "aws_iam_policy" "permissions_rw" {
  #  name = "${var.name}-permissions"
  name_prefix = "${var.name}-rw"
  policy      = data.aws_iam_policy_document.permissions_rw.json
}

resource "aws_iam_role_policy_attachment" "state-manager-ro" {
  policy_arn = aws_iam_policy.permissions_ro.arn
  role       = aws_iam_role.state-manager.name
}

resource "aws_iam_role_policy_attachment" "state-manager-rw" {
  count      = var.read_only_permissions ? 0 : 1
  policy_arn = aws_iam_policy.permissions_rw.arn
  role       = aws_iam_role.state-manager.name
}
