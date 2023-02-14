// output values to present useful information to the Terraform user.

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.ec2_tf.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2_tf.public_ip
}