output "app_fqdn" {
  value = module.eu_west_1.app_fqdn
}

locals {
  environment_config = {
    region     = "eu-west-1"
    account_id = local.environment.account_id
    # app_load_balancer_security_group_id = module.eu_west_1.app_load_balancer_security_group.id
  }
}

output "environment_config_json" {
  value = jsonencode(local.environment_config)
}
