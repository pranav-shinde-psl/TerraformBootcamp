data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "pslterraformbucket"
    key    = "assignment3statefiles/vpc.tfstate"
    region = "us-west-2"
  }
}