module "eu_west_1" {
  source = "./region"
  providers = {
    aws.region     = aws.eu_west_1
    aws.management = aws.management_eu_west_1
  }
}
