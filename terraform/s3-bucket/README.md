# Simple S3 Bucket

This Terraform module creates a simple AWS S3 bucket with an automatically generated unique suffix.

## Inputs

- `bucket_prefix` - prefix used to generate the bucket name
- `versioning_enabled` - enable or disable bucket versioning
- `tags` - map of tags to apply to the bucket

## Outputs

- `bucket_name`
- `bucket_arn`
