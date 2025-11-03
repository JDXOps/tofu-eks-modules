locals {
  ebs_csi_driver_sa_name = "ebs-csi-driver"
}

data "aws_iam_policy_document" "ebs_csi_driver_assume_role_irsa" {
  count   = var.ebs_csi_driver.enabled && var.enable_irsa ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.oidc_provider[0].arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${data.aws_iam_openid_connect_provider.oidc_provider[0].url}:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "${data.aws_iam_openid_connect_provider.oidc_provider[0].url}:sub"
      values   = ["system:serviceaccount:${var.ebs_csi_driver.namespace}:${local.ebs_csi_driver_sa_name}"]
    }
  }
}

data "aws_iam_policy_document" "ebs_csi_driver_assume_role_pod_identity" {
  count = var.ebs_csi_driver.enabled && var.enable_irsa == false ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole", "sts:TagSession"]

  }
}

data "aws_iam_policy" "ebs_csi_driver_policy" {
  count = var.ebs_csi_driver.enabled ? 1 : 0
  arn = "arn:aws:iam::aws:policy/AmazonEBSCSIDriverPolicy"
}

resource "aws_iam_role" "ebs_csi_driver_role_irsa" {
  count              = var.ebs_csi_driver.enabled && var.enable_irsa ? 1 : 0
  name               = "AmazonEBSCSIDriverIAMRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver_assume_role_irsa[0].json
}

resource "aws_iam_role" "ebs_csi_driver_role_pod_identity" {
  count              = var.ebs_csi_driver.enabled && var.enable_irsa == false ? 1 : 0
  name               = "AmazonEBSCSIDriverIAMRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver_assume_role_pod_identity[0].json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_rpa_irsa" {
  count      = var.ebs_csi_driver.enabled && var.enable_irsa ? 1 : 0
  role       = aws_iam_role.ebs_csi_driver_role_irsa[0].name
  policy_arn = data.aws_iam_policy.ebs_csi_driver_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_rpa_pod_identity" {
  count      = var.ebs_csi_driver.enabled && var.enable_irsa == false ? 1 : 0
  role       = aws_iam_role.ebs_csi_driver_role_pod_identity[0].name
  policy_arn = data.aws_iam_policy.ebs_csi_driver_policy[0].arn
}

resource "helm_release" "ebs_csi_driver" {
  count      = var.ebs_csi_driver.enabled ? 1 : 0 
  name       = "aws-ebs-csi-driver"
  namespace  = var.ebs_csi_driver.namespace
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = var.ebs_csi_driver.chart_version

  set = concat([
    {
      name  = "serviceAccount.create"
      value = var.ebs_csi_driver.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.ebs_csi_driver_sa_name
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.ebs_csi_driver_role_irsa[0].arn
    },
    ], var.enable_irsa ? [{
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = try(aws_iam_role.ebs_csi_driver_role_irsa[0].arn, "")
  }] : [])

}

resource "aws_eks_pod_identity_association" "ebs_csi_driver" {
  count           = var.ebs_csi_driver.enabled && var.enable_irsa == false ? 1 : 0
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  namespace       = var.ebs_csi_driver.namespace
  service_account = local.ebs_csi_driver_sa_name
  role_arn        = aws_iam_role.ebs_csi_driver_role_pod_identity[0].arn
}



