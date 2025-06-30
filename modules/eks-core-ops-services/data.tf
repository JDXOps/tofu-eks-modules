data "aws_eks_cluster" "eks_cluster" {
  name = var.cluster_name
}

data "aws_region" "current" {}

data "aws_iam_openid_connect_provider" "oidc_provider" {
  arn = var.oidc_provider_arn
}