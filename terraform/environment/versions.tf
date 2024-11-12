terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = "1.9.8"
}
