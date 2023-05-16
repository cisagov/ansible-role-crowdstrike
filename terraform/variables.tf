# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "production_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the production Falcon sensor system packages live."
  default     = "cisa-cool-third-party-production"
}

variable "production_objects" {
  type        = list(string)
  description = "The Falcon sensor system package objects inside the production bucket."
  default = [
    "falcon-sensor_*_amd64.deb",
  ]
}

variable "staging_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where the staging Falcon sensor system packages live."
  default     = "cisa-cool-third-party-staging"
}

variable "staging_objects" {
  type        = list(string)
  description = "The Falcon sensor system packages inside the staging bucket."
  default = [
    "falcon-sensor_*_amd64.deb",
  ]
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all AWS resources created"

  default = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-crowdstrike testing"
  }
}
