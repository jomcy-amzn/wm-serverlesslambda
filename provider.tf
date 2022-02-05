

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }
  required_version = "1.1.5"
}

provider "aws" {
  version = "3.74.0"
  region  = var.region
}
