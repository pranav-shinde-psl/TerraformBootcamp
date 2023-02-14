terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 3.0"
    }
  }

  // adding backend s3 to store tfstate files
  backend "s3" {
    bucket = "pslterraformbucket"
    key    = "tf-state-file.tfstate"
    region = "us-west-2"
  }
}

provider "aws" {
  region = "us-west-2"// region
}