variable "bucket_prefix" {
  description = "Prefix used to generate a globally unique S3 bucket name."
  type        = string
  default     = "stackauto-demo"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.bucket_prefix))
    error_message = "bucket_prefix must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "versioning_enabled" {
  description = "Enable S3 bucket versioning."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket."
  type        = map(string)
  default     = {}
}
