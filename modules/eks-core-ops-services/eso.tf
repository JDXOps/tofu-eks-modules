locals {
  eso_sa_name = "external-secrets"
}

data "aws_iam_policy_document" "eso_assume_role_irsa" {
  count   = var.eso.enabled && var.enable_irsa ? 1 : 0
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
      values   = ["system:serviceaccount:${var.eso.namespace}:${local.eso_sa_name}"]
    }
  }
}

data "aws_iam_policy_document" "eso_assume_role_pod_identity" {
  count   = var.eso.enabled && var.enable_irsa == false ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole", "sts:TagSession"]
  }
}


data "aws_iam_policy_document" "eso_policy_document" {
  count   = var.eso.enabled ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]

    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:*"
    ]
  }
}


resource "aws_iam_policy" "eso_policy" {
  count       = var.eso.enabled ? 1 : 0
  name        = "ExternalSecrets-${var.cluster_name}"
  description = "IAM Policy for External Secrets Operator Kubernetes service account"
  policy      = data.aws_iam_policy_document.eso_policy_document[0].json
}

resource "aws_iam_role" "eso_role_irsa" {
  count              = var.eso.enabled && var.enable_irsa ? 1 : 0
  name               = "AWSExternalSecretsOperatorIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.eso_assume_role_irsa[0].json
}

resource "aws_iam_role" "eso_role_pod_identity" {
  count              = var.eso.enabled && var.enable_irsa == false ? 1 : 0
  name               = "AWSExternalSecretsOperatorIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.eso_assume_role_pod_identity[0].json
}

resource "aws_iam_role_policy_attachment" "eso_rpa_irsa" {
  count      = var.eso.enabled && var.enable_irsa ? 1 : 0
  role       = aws_iam_role.eso_role_irsa[0].name
  policy_arn = aws_iam_policy.eso_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "eso_rpa_pod_identity" {
  count      = var.eso.enabled && var.enable_irsa == false ? 1 : 0
  role       = aws_iam_role.eso_role_pod_identity[0].name
  policy_arn = aws_iam_policy.eso_policy[0].arn
}

resource "helm_release" "external_secrets_operator_pod_identity" {
  count            = var.eso.enabled && var.enable_irsa == false ? 1 : 0
  name             = "external-secrets-operator"
  namespace        = var.eso.namespace
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  create_namespace = true
  version          = var.eso.chart_version

  set = [
    {
      name  = "serviceAccount.create"
      value = var.eso.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.eso_sa_name
    },
  ]
}

resource "helm_release" "external_secrets_operator" {
  count            = var.eso.enabled && var.enable_irsa ? 1 : 0
  name             = "external-secrets-operator"
  namespace        = var.eso.namespace
  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  create_namespace = true
  version          = var.eso.chart_version

  set = [
    {
      name  = "serviceAccount.create"
      value = var.eso.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.eso_sa_name
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.eso_role_irsa[0].arn
    },
  ]
}


resource "aws_eks_pod_identity_association" "eso_pod_identity" {
  count      = var.eso.enabled && var.enable_irsa == false ? 1 : 0
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  namespace       = var.eso.namespace
  service_account = local.eso_sa_name
  role_arn        = aws_iam_role.eso_role_pod_identity[0].arn
}