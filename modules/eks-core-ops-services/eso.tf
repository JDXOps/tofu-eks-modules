locals {
  eso_sa_name = "external-secrets"
}

data "aws_iam_policy_document" "eso_assume_role" {
  count   = var.eso.enabled ? 1 : 0
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
      values   = ["system:serviceaccount:${var.eso.namespace}:${local.eso_sa_name}"]
    }
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

resource "aws_iam_role" "eso_role" {
  count              = var.eso.enabled ? 1 : 0
  name               = "AWSExternalSecretsOperatorIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.eso_assume_role[0].json
}

resource "aws_iam_role_policy_attachment" "eso_rpa" {
  count      = var.eso.enabled ? 1 : 0
  role       = aws_iam_role.eso_role[0].name
  policy_arn = aws_iam_policy.eso_policy[0].arn
}

resource "helm_release" "external_secrets_operator" {
  count            = var.eso.enabled ? 1 : 0
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
      value = aws_iam_role.eso_role[0].arn
    },
  ]
}
