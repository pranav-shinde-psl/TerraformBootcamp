//A vpc is an isolated portion on the AWS cloud infrastructure that allows you to launch your AWS resources with particular rules and policies that you define.
resource "aws_vpc" "psl_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "ec2_vpc"
  }
}

//A subnet is simply a range of IP addresses in your VPC and we are going to provision our resources in one subnet.
resource "aws_subnet" "psl_public_subnet" {
  vpc_id                  = aws_vpc.psl_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.aws_region

  tags = {
    Name = "dev-public"
  }
}

//To give the instances in our VPC the ability to connect to the internet from the amazon network, we need to attach an internet gateway.
resource "aws_internet_gateway" "psl_internet_gateway" {
  vpc_id = aws_vpc.psl_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

//A route table contains a set of rules, called routes, that are used to determine where network traffic is directed. So basically how traffic can flow amongst the members of the vpc(subnets, instances etc) and also out of the vpc e.g to the internet.
resource "aws_route_table" "psl_public_rt" {
  vpc_id = aws_vpc.psl_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}

//“0.0.0.0/0” means that anytime our resources want to communicate(both inbound and outbound) with the internet they have to pass through the internet gateway.
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.psl_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.psl_internet_gateway.id
}

//We want to bridge the gap between our route table and our subnet by providing a route table association.
resource "aws_route_table_association" "my_public_assoc" {
  subnet_id      = aws_subnet.psl_public_subnet.id
  route_table_id = aws_route_table.psl_public_rt.id
}

//A security group acts as a virtual firewall for your instance to control inbound and outbound traffic.
resource "aws_security_group" "my_sg" {
  name        = "ec2-tf"
  description = "ec2 security group"
  vpc_id      = aws_vpc.psl_vpc.id

  //Ingress or Inbound Rules control the traffic that’s allowed to reach the instance. Here we are allowing traffic from all ports but in the cidr_block you can put in your IP address to specify that you want to access the instances in your vpc from only your IP
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  //egress: Egress or Outbound Rules controls the traffic going out of the instance. Here the cidr_block is “0.0.0.0/0" because we want it to be able to access the internet.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "ec2_tf" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.ubuntu.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.psl_public_subnet.id


#   root_block_device {
#     volume_size = 20
#   }
  tags = {
    Name = "ec2-tf"
  }
}