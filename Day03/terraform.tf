// terraform block contains the required_providers block, 
// which specifies the provider local name, the source address, and the version.
// When initialize this configuration, Terraform will download all this providers
terraform {

  cloud {
    organization = "PSL-Terraform-Bootcamp"
    workspaces {
      name = "tfc-ec2-creation-assignment"
    }
  }
  required_providers {
    //A AWS provider is a plugin that Terraform uses to create and manage resources.
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0" //specifies that only Terraform binaries newer than v1.2.0 can run this configuration
}

//A provider is a plugin that Terraform uses to create and manage your resources.
provider "aws" {
  region = var.aws_region // region
}
