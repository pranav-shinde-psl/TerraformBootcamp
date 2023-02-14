resource "aws_eks_cluster" "example" {
  name     = "example-eks-cluster"
  vpc_config {
    subnet_ids = data.terraform_remote_state.subnet.aws_subnet.psl_public_subnet.id
  }
}