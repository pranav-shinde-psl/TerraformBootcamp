output "vpc_id" {
    description = "ID of the vpc instance"
  value = aws_vpc.psl_vpc.id
}