terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.4.0"
    }
  }
    // adding backend s3 to store tfstate files
  backend "s3" {
    bucket = "pslterraformbucket"
    key    = "assignment3statefiles/vpc.tfstate"
    region = "us-west-2"
  }

  required_version = ">= 1.1"
}
provider "aws" {
  region = "us-west-2"
}