locals {
  create_kms_key = var.existing_key_arn == ""
}
data "aws_organizations_organization" "main" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
resource "aws_organizations_account" "log_archive" {
  name  = var.account_name_log_archiver
  email = var.email_address_account_log_archiver

  close_on_deletion = false

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_organizations_account" "audit" {
  name  = var.account_name_audit
  email = var.email_address_account_audit

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_role" "controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "controltower.amazonaws.com"
        }
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}


resource "aws_iam_policy" "controltower_admin_policy" {
  name        = "AWSControlTowerAdminPolicy"
  path        = "/service-role/"
  description = "AWS Control Tower policy to manage AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:DescribeAvailabilityZones"
        Resource = "*"
        Effect   = "Allow"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_role_policy_attachment" "controltower_admin_policy_attachment" {
  role       = aws_iam_role.controltower_admin.name
  policy_arn = aws_iam_policy.controltower_admin_policy.arn
}

resource "aws_iam_role" "cloudtrail" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_policy" "cloudtrail_policy" {
  name        = "AWSControlTowerCloudTrailRolePolicy"
  path        = "/service-role/"
  description = "AWS Cloud Trail assumes this role to create and publish Cloud Trail logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "logs:CreateLogStream"
        Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
        Effect   = "Allow"
      },
      {
        Action   = "logs:PutLogEvents"
        Resource = "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*"
        Effect   = "Allow"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_role_policy_attachment" "cloudtrail_policy_attachment" {
  role       = aws_iam_role.cloudtrail.name
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
}


resource "aws_iam_role" "stackset" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudformation.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_policy" "stackset_policy" {
  name        = "AWSControlTowerStackSetRolePolicy"
  path        = "/service-role/"
  description = "AWS CloudFormation assumes this role to deploy stacksets in accounts created by AWS Control Tower"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/AWSControlTowerExecution"
        ]
        Effect = "Allow"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_role_policy_attachment" "stackset_policy_attachment" {
  role       = aws_iam_role.stackset.name
  policy_arn = aws_iam_policy.stackset_policy.arn
}

resource "aws_iam_role" "config_aggregator" {
  name = "AWSControlTowerConfigAggregatorRoleForOrganizations"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  lifecycle {
    prevent_destroy = true
  }

  tags = module.this.tags
}

resource "aws_iam_role_policy_attachment" "config_aggregator" {
  role       = aws_iam_role.config_aggregator.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}


resource "aws_kms_key" "controltower" {
  count                   = local.create_kms_key ? 1 : 0
  description             = "The AWS Key used in AWS Control Tower for encryption and decryption in the landing zone"
  enable_key_rotation     = true
  deletion_window_in_days = 20
  tags                    = module.this.tags
}

resource "aws_kms_key_policy" "controltower" {
  count  = local.create_kms_key ? 1 : 0
  key_id = aws_kms_key.controltower[0].key_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = concat([
      {
        Sid    = "Allow Config to use KMS for encryption"
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ]
        Resource = aws_kms_key.controltower[0].arn
      },
      {
        Sid    = "Allow CloudTrail to use KMS for encryption"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = [
          "kms:GenerateDataKey*",
          "kms:Decrypt"
        ]
        Resource = aws_kms_key.controltower[0].arn
        Condition = {
          StringEquals = {
            "aws:SourceArn" = "arn:aws:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/aws-controltower-BaselineCloudTrail"
          }
          StringLike = {
            "kms:EncryptionContext:aws:cloudtrail:arn" = "arn:aws:cloudtrail:*:${data.aws_caller_identity.current.account_id}:trail/*"
          }
        }
      },
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = aws_kms_key.controltower[0].arn
      }],
      length(var.kms_key_admins) > 0 ? [
        {
          Sid    = "Allow KMS Admins"
          Effect = "Allow"
          Principal = {
            AWS = var.kms_key_admins
          }
          Action = [
            "kms:Create*",
            "kms:Describe*",
            "kms:Enable*",
            "kms:List*",
            "kms:Put*",
            "kms:Update*",
            "kms:Revoke*",
            "kms:Disable*",
            "kms:Get*",
            "kms:Delete*",
            "kms:TagResource",
            "kms:UntagResource",
            "kms:ScheduleKeyDeletion",
            "kms:CancelKeyDeletion"
          ]
          Resource = aws_kms_key.controltower[0].arn
        }
      ] : [],
      length(var.kms_key_users) > 0 ? [
        {
          Sid    = "Allow KMS Users"
          Effect = "Allow"
          Principal = {
            AWS = var.kms_key_users
          }
          Action = [
            "kms:Encrypt",
            "kms:Decrypt",
            "kms:ReEncrypt*",
            "kms:GenerateDataKey*",
            "kms:DescribeKey"
          ]
          Resource = aws_kms_key.controltower[0].arn
        }
    ] : [])
  })
}

resource "aws_kms_alias" "controltower" {
  count         = local.create_kms_key ? 1 : 0
  name          = "alias/${var.kms_key_alias_name}"
  target_key_id = aws_kms_key.controltower[0].key_id

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_controltower_landing_zone" "zone" {
  version = var.landing_zone_version
  manifest_json = jsonencode({
    accessManagement = {
      enabled = var.enable_access_management
    }
    securityRoles = {
      accountId = aws_organizations_account.audit.id
    }
    governedRegions = var.governed_regions
    organizationStructure = {
      sandbox = {
        name = var.additional_organizational_unit_name
      }
      security = {
        name = var.foundational_organizational_unit_name
      }
    }
    centralizedLogging = {
      accountId = aws_organizations_account.log_archive.id
      configurations = {
        loggingBucket = {
          retentionDays = tostring(var.logging_bucket_retention_days)
        }
        accessLoggingBucket = {
          retentionDays = tostring(var.access_logging_bucket_retention_days)
        }
        kmsKeyArn = local.create_kms_key ? aws_kms_key.controltower[0].arn : var.existing_key_arn
      }
      enabled = true
    }
  })

  tags = module.this.tags


  timeouts {
    create = var.create_operation_timeout
    update = var.update_operation_timeout
    delete = var.delete_operation_timeout
  }

  depends_on = [
    aws_organizations_account.audit,
    aws_organizations_account.log_archive,
    aws_iam_role.controltower_admin,
    aws_iam_role.cloudtrail,
    aws_iam_role.stackset,
    aws_iam_role.config_aggregator,
    aws_kms_key.controltower
  ]
}
