data "aws_route53_zone" "modernising_lpa" {
  provider = aws.management
  name     = "modernising.opg.service.justice.gov.uk"
}

locals {
  dns_namespace_for_environment = data.aws_default_tags.current.tags.account-name == "production" ? "" : "${data.aws_default_tags.current.tags.environment-name}."
}

resource "aws_route53_record" "app" {
  # mainstreamcontent.modernising.opg.service.justice.gov.uk
  provider       = aws.management
  zone_id        = data.aws_route53_zone.modernising_lpa.zone_id
  name           = "${local.dns_namespace_for_environment}mainstreamcontent.${data.aws_route53_zone.modernising_lpa.name}"
  type           = "A"
  set_identifier = data.aws_region.current.name

  alias {
    evaluate_target_health = false
    name                   = module.app.load_balancer.dns_name
    zone_id                = module.app.load_balancer.zone_id
  }

  weighted_routing_policy {
    weight = var.dns_weighting
  }

  lifecycle {
    create_before_destroy = true
  }
}
