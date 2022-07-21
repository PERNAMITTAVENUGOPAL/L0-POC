terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
  access_key = "AKIA4Y4YI7QDJTGD6V4C"
  secret_key = "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"
}