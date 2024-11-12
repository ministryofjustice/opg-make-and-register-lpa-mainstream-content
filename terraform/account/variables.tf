output "workspace_name" {
  value = terraform.workspace
}

variable "accounts" {
  type = map(
    object({
      account_id    = string
      account_name  = string
      is_production = bool
    })
  )
}

locals {
  account_name = lower(replace(terraform.workspace, "_", "-"))
  account      = var.accounts[local.account_name]


  mandatory_moj_tags = {
    business-unit    = "OPG"
    application      = "opg-mrlpa-mainstream-content"
    environment-name = local.account.account_name
    owner            = "OPG Webops: opgteam+opg-mrlpa-mainstream-content@digital.justice.gov.uk"
    is-production    = local.account.is_production
    runbook          = "https://github.com/ministryofjustice/opg-make-and-register-lpa-mainstream-content"
    source-code      = "https://github.com/ministryofjustice/opg-make-and-register-lpa-mainstream-content"
  }



  optional_tags = {
    account-name           = local.account.account_name
    infrastructure-support = "OPG Webops: opgteam+opg-mrlpa-mainstream-content@digital.justice.gov.uk"
  }

  default_tags = merge(local.mandatory_moj_tags, local.optional_tags)
}
