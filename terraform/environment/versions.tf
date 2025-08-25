terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.100.0"
    }
    local = {
      source = "hashicorp/local"
    }
  }
  required_version = "1.13.0"
}
