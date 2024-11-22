resource "aws_ecs_cluster" "main" {
  name = data.aws_default_tags.current.tags.environment-name
  # setting {
  #   name  = "containerInsights"
  #   value = "enabled"
  # }
  provider = aws.region
}
