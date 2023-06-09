# *.dev.cohortscdi.five

# define a provider in the account where this subdomain will be managed
provider "aws" {
  alias  = "subdomain_dev_cohortscdi_five"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "five-lab-platform-hosted-zones"
  }
}

# create a route53 hosted zone for the subdomain in the account defined by the provider above
module "subdomain_dev_cohortscdi_five" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.subdomain_dev_cohortscdi_five
  }

  zones = {
    "dev.${local.domain_cohortscdi_five}" = {
      tags = {
        cluster = "nonprod"
      }
    }
  }

  tags = {
    pipeline = "five-lab-platform-hosted-zones"
  }
}

# Create a zone delegation in the top level domain for this subdomain
module "subdomain_zone_delegation_dev_cohortscdi_five" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.0.0"
  create  = true

  providers = {
    aws = aws.domain_cohortscdi_five
  }

  private_zone = false
  zone_name = local.domain_cohortscdi_five
  records = [
    {
      name            = "dev"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.zone_id_cohortscdi_five.id
      allow_overwrite = true
      records         = lookup(module.subdomain_dev_cohortscdi_five.route53_zone_name_servers,"dev.${local.domain_cohortscdi_five}")
    }
  ]

  depends_on = [module.subdomain_dev_cohortscdi_five]
}
