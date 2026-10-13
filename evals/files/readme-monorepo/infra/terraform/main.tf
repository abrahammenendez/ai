terraform {
  required_version = ">= 1.6"
}

resource "aws_eks_cluster" "main" {
  name     = "shopfleet"
  role_arn = var.cluster_role_arn
}

variable "cluster_role_arn" {
  type = string
}
