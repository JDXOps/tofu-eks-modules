
data "aws_iam_policy_document" "eks_assume_node_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eks_node_role" {
  name                = "${var.cluster_name}-eks-node-role"
  assume_role_policy  = data.aws_iam_policy_document.eks_assume_node_role_policy_document.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy", "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly", "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"]
}

resource "aws_eks_node_group" "eks_nodegroup" {
  for_each        = var.managed_nodegroups
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  node_group_name = each.value.node_group_name
  version         = data.aws_eks_cluster.eks_cluster.version
  subnet_ids      = each.value.subnet_ids
  node_role_arn   = aws_iam_role.eks_node_role.arn
  disk_size       = each.value.disk_size

  scaling_config {
    min_size     = each.value.min_size
    max_size     = each.value.max_size
    desired_size = each.value.desired_size

  }

  update_config {
    max_unavailable = each.value.max_unavailable
  }

  dynamic "taint" {
    for_each = try(each.value.taints, [])
    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  labels = each.value.labels

  ami_type       = each.value.ami_type
  capacity_type  = each.value.capacity_type
  instance_types = each.value.instance_types

  tags = each.value.tags
} 