resource "aws_ecs_cluster" "main" {
  name = data.aws_default_tags.current.tags.environment-name
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
  provider = aws.region
}


module "app" {
  source                           = "./modules/app"
  alb_deletion_protection_enabled  = false
  app_env_vars                     = []
  app_service_container_sha_digest = var.app_service_container_sha_digest
  app_service_repository_url       = var.app_service_repository_url
  container_port                   = 3000
  ecs_application_log_group_name   = module.application_logs.cloudwatch_log_group.name
  ecs_capacity_provider            = "FARGATE-SPOT"
  ecs_cluster                      = aws_ecs_cluster.main.arn
  ecs_cpu_architecture             = "AMD64"
  ecs_execution_role               = var.ecs_execution_role
  ecs_service_desired_count        = 1
  ecs_task_role                    = var.ecs_task_role
  ingress_allow_list_cidr          = var.ingress_allow_list_cidr
  network = {
    vpc_id              = ""
    application_subnets = []
    public_subnets      = []
  }
  public_access_enabled       = false
  waf_alb_association_enabled = false


  providers = {
    aws.region = aws.region
  }
}

module "application_logs" {
  source = "./modules/application_logs"
  providers = {
    aws.region = aws.region
  }
}
