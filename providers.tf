terraform {
  # Pin the provider to the current major release.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Select the Region used for the network.
variable "aws_region" {
  description = "AWS Region for the virtual data center"
  type        = string
}

# Keep subnet placement consistent across two zones.
variable "availability_zones" {
  description = "Two Availability Zones in the selected Region"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Provide exactly two Availability Zones."
  }
}

provider "aws" {
  region = var.aws_region
}
