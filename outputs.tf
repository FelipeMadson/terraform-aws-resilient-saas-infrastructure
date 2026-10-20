output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "kms_key_arn" {
  description = "ARN of the KMS customer-managed key"
  value       = aws_kms_key.main.arn
}

output "s3_bucket_name" {
  description = "Name of the secure S3 artifacts bucket"
  value       = aws_s3_bucket.artifacts.id
}
