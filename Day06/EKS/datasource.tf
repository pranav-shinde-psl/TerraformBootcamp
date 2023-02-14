data "terraform_remote_state" "subnet" {
  backend = "s3"

  config = {
    bucket = "pslterraformbucket"
    key    = "assignment3statefiles/subnet.tfstate"
    region = "us-west-2"
  }
}