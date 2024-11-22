output "iam_roles" {
  value = {
    ecs_execution_role = aws_iam_role.execution_role,
    app_ecs_task_role  = aws_iam_role.app_task_role,
  }
}
