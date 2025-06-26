locals {
  subnet_ids = concat(var.private_subnet_ids, var.public_subnet_ids)
}

data "aws_iam_policy_document" "eks_assume_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "eks_kms_policy_doc" {
  statement {
    sid    = "AllowEKSControlPlaneToUseKey"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAdminAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.aws_admin_role_arn]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}


resource "aws_kms_key" "eks_secrets_kms_key" {
  description = "A KMS Key used to encrypt Kubernetes (EKS) secrets before they reach ETCD."
  policy      = aws_iam_policy_document.eks_kms_policy_doc.json
  tags        = var.tags


}

resource "aws_iam_role" "eks_cluster_role" {
  name                = "${var.name}-eks-cluster-role"
  assume_role_policy  = data.aws_iam_policy_document.eks_assume_role_policy_document.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy", "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]
  tags                = var.tags
}

resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.name
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = var.enabled_cluster_log_types
  version                   = var.cluster_version

  vpc_config {
    subnet_ids              = local.subnet_ids
    endpoint_private_access = var.enable_endpoint_private_access ? true : false
    endpoint_public_access  = var.enable_endpoint_private_access ? false : true
    public_access_cidrs     = var.enable_endpoint_private_access ? [] : var.public_access_cidrs
  }

  access_config {
    authentication_mode                         = var.authentication_mode
    bootstrap_cluster_creator_admin_permissions = var.bootstrap_cluster_creator_admin_permissions
  }


  # Encrypt secrets before they are stored in etcd.
  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_secrets_kms_key.key_arn
    }

    resources = ["secrets"]

  }

  tags = var.tags


  depends_on = [aws_iam_role.eks_cluster_role]
}