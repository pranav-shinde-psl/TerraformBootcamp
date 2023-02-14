variable "aws_region" {
  description = "Value of the aws provider region for the EC2 instance"
  type        = string
  default     = "us-west-2a"
}

variable "instance_type" {
    description = "Value of the instance type for the EC2 instance"
    type        = string
    default     = "t2.micro"
}