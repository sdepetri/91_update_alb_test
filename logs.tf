resource "aws_s3_bucket" "alb_logs" {
  acl           = "private"
  bucket_prefix = "${var.name}-logs"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(
    var.tags,
    {
      related_with = "alb.${var.name}"
  })
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.alb_logs.json
}

data "aws_iam_policy_document" "alb_logs" {
  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        data.aws_elb_service_account.alb.arn
      ]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.alb_logs.arn}/*",
    ]
  }
  statement {
    sid    = "RequireSecureTransport"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "*"
    }

    actions = [
      "s3:*"
    ]

    resources = [
      "${aws_s3_bucket.alb_logs.arn}",
      "${aws_s3_bucket.alb_logs.arn}/*",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.alb_logs.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
