# EKS Fargate Nodes can only run in private subnets
resource "aws_eks_fargate_profile" "fargate_profile" {
  for_each = var.fargate_profiles

  cluster_name           = data.aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = each.value.profile_name
  pod_execution_role_arn = aws_iam_role.example.arn
  subnet_ids             = each.value.subnet_ids

  dynamic "selector" {
    for_each = each.value.selectors
    content {
      namespace = selector.value.namespace
      labels    = try(selector.value.labels, null)

    }
  }

  tags = each.value.tags
}