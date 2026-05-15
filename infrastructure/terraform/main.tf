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

}

 terraform {
   backend "s3" {
    bucket         = "dave-terraform-state-bucket"
    key            = "cloud-resume/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true

     }
   }
