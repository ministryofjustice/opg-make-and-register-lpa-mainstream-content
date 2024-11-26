data "aws_ecr_repository" "make_and_register_lpa_mainstream_content" {
  name     = "make-and-register-lpa-mainstream-content"
  provider = aws.management_eu_west_1
}

data "aws_ecr_image" "make_and_register_lpa_mainstream_content" {
  repository_name = data.aws_ecr_repository.make_and_register_lpa_mainstream_content.name
  image_tag       = "v0.4.0"
  provider        = aws.management_eu_west_1
}

module "allow_list" {
  source = "git@github.com:ministryofjustice/opg-terraform-aws-moj-ip-allow-list.git?ref=v3.0.2"
}


module "eu_west_1" {
  source = "./region"
  iam_roles = {
    ecs_execution_role = module.global.iam_roles.ecs_execution_role
    app_ecs_task_role  = module.global.iam_roles.app_ecs_task_role
  }
  mrlpa_content_container_sha_digest = data.aws_ecr_image.make_and_register_lpa_mainstream_content.image_digest
  mrlpa_content_repository_url       = data.aws_ecr_repository.make_and_register_lpa_mainstream_content.repository_url
  ingress_allow_list_cidr            = module.allow_list.moj_sites
  dns_weighting                      = 255
  providers = {
    aws.region     = aws.eu_west_1
    aws.management = aws.management_global
  }
}
