#=====================================================
# ROOT TERRAFORM CONFIGURATION
#====================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "dave-cloud-resume-tfstate-178845344404"
    key          = "cloud-resume/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
