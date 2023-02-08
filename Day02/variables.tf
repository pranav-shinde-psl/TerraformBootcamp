// store values in this file and use it wherever we want instead of hardcoding in main.tf

variable "aws_region" {
  description = "Value of the aws provider region for the EC2 instance"
  type        = string
  default     = "us-west-2"
}

variable "aws_EC2_ami" {
  description = "Value of the instance AMI for the EC2 instance"
  type        = string
  default     = "ami-830c94e3"
}

variable "aws_EC2_instance_type" {
  description = "Value of the instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "aws_EC2_instance_tagName" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "Terraform_EC2_instance"
}
