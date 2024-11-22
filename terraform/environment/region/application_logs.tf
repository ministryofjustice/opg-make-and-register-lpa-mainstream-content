module "application_logs" {
  source = "./modules/application_logs"
  providers = {
    aws.region = aws.region
  }

}
