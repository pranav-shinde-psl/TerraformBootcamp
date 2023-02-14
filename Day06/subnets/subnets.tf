//A subnet is simply a range of IP addresses in your VPC and we are going to provision our resources in one subnet.
resource "aws_subnet" "psl_public_subnet" {
  vpc_id                  = data.terraform_remote_state.vpc.aws_vpc.psl_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2"

  tags = {
    Name = "tfbootcamp-subnets"
  }
}