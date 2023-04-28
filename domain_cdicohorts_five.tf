locals {
  domain_twdps_digital = "cohortscdi-five.com"
}

provider "aws" {
  alias  = "domain_cohortscdi_five"
  region = "us-east-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "zone_id_cohortscdi_five" {
  provider = aws.domain_cohortscdi_five
  name     = local.domain_cohortscdi_five
}
