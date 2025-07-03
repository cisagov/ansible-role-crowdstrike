# ------------------------------------------------------------------------------
# Required parameters
#
# You must provide a value for each of these parameters.
# ------------------------------------------------------------------------------

variable "crowdstrike_bucket" {
  description = "The name of the S3 bucket where the Crowdstrike files live."
  nullable    = false
  type        = string
}

variable "terraform_state_bucket" {
  description = "The name of the S3 bucket where Terraform state is stored."
  nullable    = false
  type        = string
}

# ------------------------------------------------------------------------------
# Optional parameters
#
# These parameters have reasonable defaults.
# ------------------------------------------------------------------------------

variable "aws_region" {
  default     = "us-east-1"
  description = "The AWS region to deploy into (e.g. us-east-1)."
  nullable    = false
  type        = string
}

variable "crowdstrike_objects" {
  type        = list(string)
  description = "The Falcon sensor system package objects inside the bucket."
  default = [
    "Falcon Linux Sensor*.gpg",
    "Falcon_Linux_Sensor*.gpg",
    "falcon-sensor_*.deb",
    "falcon-sensor-*.rpm",
  ]
}

variable "tags" {
  default = {
    Team        = "VM Fusion - Development"
    Application = "ansible-role-crowdstrike testing"
  }
  description = "Tags to apply to all AWS resources created"
  nullable    = false
  type        = map(string)
}
