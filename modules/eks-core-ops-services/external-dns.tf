data "aws_iam_policy_document" "external_dns" {
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResources"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "route53:ListHostedZones"
    ]
    resources = [
      "*"
    ]
  }
}



#################

locals {
  external_dns_sa_name = "external-dns"
}

data "aws_iam_policy_document" "external_dns_assume_role_irsa" {
  count   = var.external_dns.enabled && var.enable_irsa ? 1 : 0
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
      values   = ["system:serviceaccount:${var.external_dns.namespace}:${local.external_dns_sa_name}"]
    }
  }
}

data "aws_iam_policy_document" "external_dns_assume_role_pod_identity" {
  count = var.external_dns.enabled && var.enable_irsa == false ? 1 : 0
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole", "sts:TagSession"]

  }
}

resource "aws_iam_policy" "external_dns_policy" {
  count       = var.external_dns.enabled ? 1 : 0
  description = "External DNS IAM Policy"
  name        = "ExternalDNSIAMPolicy"
  policy      = data.aws_iam_policy_document.external_dns.json

}

resource "aws_iam_role" "external_dns_role_irsa" {
  count              = var.external_dns.enabled && var.enable_irsa ? 1 : 0
  name               = "ExternalDNSIAMRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_irsa[0].json
}

resource "aws_iam_role" "external_dns_role_pod_identity" {
  count              = var.external_dns.enabled && var.enable_irsa == false ? 1 : 0
  name               = "ExternalDNSIAMRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_pod_identity[0].json
}

resource "aws_iam_role_policy_attachment" "external_dns_rpa_irsa" {
  count      = var.external_dns.enabled && var.enable_irsa ? 1 : 0
  role       = aws_iam_role.external_dns_role_irsa[0].name
  policy_arn = aws_iam_policy.external_dns_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "external_dns_rpa_pod_identity" {
  count      = var.external_dns.enabled && var.enable_irsa == false ? 1 : 0
  role       = aws_iam_role.external_dns_role_pod_identity[0].name
  policy_arn = aws_iam_policy.external_dns_policy[0].arn
}

resource "helm_release" "external_dns" {
  count      = var.external_dns.enabled ? 1 : 0
  name       = "external-dns"
  namespace  = var.external_dns.namespace
  repository = "https://kubernetes-sigs.github.io/external-dns"
  chart      = "external-dns"
  version    = var.external_dns.chart_version

  depends_on = [kubernetes_namespace.kube_ops]

  set = concat([
    {
      name  = "serviceAccount.create"
      value = var.external_dns.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.external_dns_sa_name
    },
    ], var.enable_irsa ? [{
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = try(aws_iam_role.external_dns_role_irsa[0].arn, "")
  }] : [])

}

resource "aws_eks_pod_identity_association" "external_dns" {
  count           = var.external_dns.enabled && var.enable_irsa == false ? 1 : 0
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  namespace       = var.external_dns.namespace
  service_account = local.external_dns_sa_name
  role_arn        = aws_iam_role.external_dns_role_pod_identity[0].arn
}



