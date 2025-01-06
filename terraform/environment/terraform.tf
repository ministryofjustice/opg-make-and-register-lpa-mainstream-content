terraform {
  backend "s3" {
    bucket  = "opg.terraform.state"
    key     = "opg-mrlpa-mainstream-content-environment/terraform.tfstate"
    encrypt = true
    region  = "eu-west-1"
    assume_role = {
      role_arn = "arn:aws:iam::311462405659:role/opg-mrlpa-mainstream-content-state-access"
    }
    dynamodb_table = "remote_lock"
  }
}

variable "default_role" {
  type    = string
  default = "mrlpa-mc-ci"
}

provider "aws" {
  alias  = "eu_west_1"
  region = "eu-west-1"
  default_tags {
    tags = local.default_tags
  }
  assume_role {
    role_arn     = "arn:aws:iam::${local.environment.account_id}:role/${var.default_role}"
    session_name = "opg-mrlpa-mainstream-content-terraform-session"
  }
}

provider "aws" {
  alias  = "global"
  region = "us-east-1"
  default_tags {
    tags = local.default_tags
  }
  assume_role {
    role_arn     = "arn:aws:iam::${local.environment.account_id}:role/${var.default_role}"
    session_name = "opg-mrlpa-mainstream-content-terraform-session"
  }
}

provider "aws" {
  alias  = "management_eu_west_1"
  region = "eu-west-1"
  default_tags {
    tags = local.default_tags
  }
  assume_role {
    role_arn     = "arn:aws:iam::311462405659:role/${var.default_role}"
    session_name = "opg-mrlpa-mainstream-content-terraform-session"
  }
}
provider "aws" {
  alias  = "management_global"
  region = "us-east-1"
  default_tags {
    tags = local.default_tags
  }
  assume_role {
    role_arn     = "arn:aws:iam::311462405659:role/${var.default_role}"
    session_name = "opg-mrlpa-mainstream-content-terraform-session"
  }
}
