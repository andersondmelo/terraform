terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

}

provider "aws" {
  region              = var.region
  shared_config_files = ["config-profile"]
  profile             = var.profile

}


