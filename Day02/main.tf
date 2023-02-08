//Resource blocks to define components of your infrastructure
resource "aws_instance" "ec2_instance" {
  ami           = var.aws_EC2_ami           //  AMI to use for the instance
  instance_type = var.aws_EC2_instance_type // Instance type to use for the instance
  tags = {
    Name = var.aws_EC2_instance_tagName // Tag name for ec2 instance
  }
}