output "audit_account_id" {
  description = "The AWS account ID of the Control Tower audit account"
  value       = aws_organizations_account.audit.id
}

output "landing_zone_arn" {
  description = "The ARN of the Control Tower landing zone"
  value       = aws_controltower_landing_zone.zone.arn
}

output "log_archive_account_id" {
  description = "The AWS account ID of the Control Tower log archive account"
  value       = aws_organizations_account.log_archive.id
}

output "manifest" {
  description = "The manifest configuration used to create the Control Tower landing zone"
  value       = aws_controltower_landing_zone.zone.manifest
}
