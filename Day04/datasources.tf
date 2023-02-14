//data source uses filter to get the most recent Ubuntu 20.04 LTS (Focal Fossa) AMI ID.
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.*"]
  }
}