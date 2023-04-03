terraform {
  required_providers {
    aws = {
      version = "= 3.3.0"
    }
  }
}

# Brainboard aliases for AWS regions
provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}
provider "aws" {
  alias  = "ap-southeast-2"
  region = "ap-southeast-2"
}
