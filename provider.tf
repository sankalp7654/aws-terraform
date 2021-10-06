terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.35.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "2.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
  required_version = ">= 0.13"
}

provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region                  = local.aws.region
  profile                 = local.aws.aws_profile_name
}