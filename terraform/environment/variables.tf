output "workspace_name" {
  value = terraform.workspace
}

variable "container_version" {
  type    = string
  default = "latest"
}

# variable "public_access_enabled" {
#   type    = bool
#   default = false
# }

output "container_version" {
  value = var.container_version
}

variable "environments" {
  type = map(
    object({
      account_id        = string
      account_name      = string
      is_production     = bool
      mrlpa_service_url = string
    })
  )
}

locals {
  environment_name = lower(replace(terraform.workspace, "_", "-"))
  environment      = contains(keys(var.environments), local.environment_name) ? var.environments[local.environment_name] : var.environments["default"]

  mandatory_moj_tags = {
    business-unit    = "OPG"
    application      = "opg-mrlpa-mainstream-content"
    environment-name = local.environment_name
    owner            = "OPG Webops: opgteam+opg-mrlpa-mainstream-content@digital.justice.gov.uk"
    is-production    = local.environment.is_production
    runbook          = "https://github.com/ministryofjustice/opg-make-and-register-lpa-mainstream-content"
    source-code      = "https://github.com/ministryofjustice/opg-make-and-register-lpa-mainstream-content"
  }

  optional_tags = {
    infrastructure-support = "OPG Webops: opgteam+opg-mrlpa-mainstream-content@digital.justice.gov.uk"
    account-name           = local.environment.account_name
  }

  default_tags = merge(local.mandatory_moj_tags, local.optional_tags)
}
