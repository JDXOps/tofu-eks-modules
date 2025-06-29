## Pod Execution Role

data "aws_iam_policy_document" "eks_fargate_assume_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_fargate_role" {
  name                = "${var.cluster_name}-fargate-pod-execution-role"
  assume_role_policy  = data.aws_iam_policy_document.eks_fargate_assume_role_policy_document.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"]
}

## Fargate profiles
# EKS Fargate Nodes can only run in private subnets
resource "aws_eks_fargate_profile" "fargate_profile" {
  for_each = var.fargate_profiles

  cluster_name           = data.aws_eks_cluster.eks_cluster.name
  fargate_profile_name   = each.value.profile_name
  pod_execution_role_arn = aws_iam_role.eks_fargate_role.arn
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