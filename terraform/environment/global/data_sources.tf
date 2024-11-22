data "aws_region" "current" {
  provider = aws.global
}

data "aws_default_tags" "current" {
  provider = aws.global
}
