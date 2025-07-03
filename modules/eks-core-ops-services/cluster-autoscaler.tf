locals {
  cluster_autoscaler_sa_name = "cluster-autoscaler"
}

## Set IAM Role and set Tags 

data "aws_iam_policy_document" "cluster_autoscaler_assume_role" {
  count   = var.cluster_autoscaler.enabled ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.oidc_provider.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${data.aws_iam_openid_connect_provider.oidc_provider.url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${data.aws_iam_openid_connect_provider.oidc_provider.url}:sub"
      values   = ["system:serviceaccount:${var.cluster_autoscaler.namespace}:${local.cluster_autoscaler_sa_name}"]
    }
  }
}


data "aws_iam_policy_document" "cluster_autoscaler_policy_document" {
  count = var.cluster_autoscaler.enabled ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/k8s.io/cluster-autoscaler/${data.aws_eks_cluster.eks_cluster.name}"
      values   = ["owned"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  count       = var.cluster_autoscaler.enabled ? 1 : 0
  name        = "AWSClusterAutoscalerPolicy-${var.cluster_name}"
  description = "IAM Policy for Cluster Autoscaler Kubernetes service account"
  policy      = data.aws_iam_policy_document.cluster_autoscaler_policy_document[0].json
}

resource "aws_iam_role" "cluster_autoscaler_role" {
  count              = var.cluster_autoscaler.enabled ? 1 : 0
  name               = "AWSClusterAutoscalerIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_rpa" {
  count      = var.cluster_autoscaler.enabled ? 1 : 0
  role       = aws_iam_role.cluster_autoscaler_role[0].name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy[0].arn
}


resource "helm_release" "cluster_autoscaler" {
  count      = var.cluster_autoscaler.enabled ? 1 : 0
  name       = "cluster-autoscaler"
  namespace  = var.cluster_autoscaler.namespace
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.cluster_autoscaler.chart_version


  set = [
    {
      name  = "autoDiscovery.clusterName"
      value = data.aws_eks_cluster.eks_cluster.name
    },
    {
      name  = "rbac.serviceAccount.create"
      value = var.cluster_autoscaler.create_service_account
    },
    {
      name  = "rbac.serviceAccount.name"
      value = local.cluster_autoscaler_sa_name
    },
    {
      name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.cluster_autoscaler_role[0].arn
    },
  ]
}