locals {
  alb_sa_name = "aws-load-balancer-controller"
}


data "aws_iam_policy_document" "aws_alb_controller_policy_doc" {
  count = var.alb_controller.enabled ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "iam:CreateServiceLinkedRole"
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "iam:AWSServiceName"
      values = [
        "elasticloadbalancing.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAddresses",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeVpcs",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeTags",
      "ec2:GetCoipPoolUsage",
      "ec2:DescribeCoipPools",
      "ec2:GetSecurityGroupsForVpc",
      "ec2:DescribeIpamPools",
      "ec2:DescribeRouteTables",
      "elasticloadbalancing:DescribeLoadBalancers",
      "elasticloadbalancing:DescribeLoadBalancerAttributes",
      "elasticloadbalancing:DescribeListeners",
      "elasticloadbalancing:DescribeListenerCertificates",
      "elasticloadbalancing:DescribeSSLPolicies",
      "elasticloadbalancing:DescribeRules",
      "elasticloadbalancing:DescribeTargetGroups",
      "elasticloadbalancing:DescribeTargetGroupAttributes",
      "elasticloadbalancing:DescribeTargetHealth",
      "elasticloadbalancing:DescribeTags",
      "elasticloadbalancing:DescribeTrustStores",
      "elasticloadbalancing:DescribeListenerAttributes",
      "elasticloadbalancing:DescribeCapacityReservation"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "cognito-idp:DescribeUserPoolClient",
      "acm:ListCertificates",
      "acm:DescribeCertificate",
      "iam:ListServerCertificates",
      "iam:GetServerCertificate",
      "waf-regional:GetWebACL",
      "waf-regional:GetWebACLForResource",
      "waf-regional:AssociateWebACL",
      "waf-regional:DisassociateWebACL",
      "wafv2:GetWebACL",
      "wafv2:GetWebACLForResource",
      "wafv2:AssociateWebACL",
      "wafv2:DisassociateWebACL",
      "shield:GetSubscriptionState",
      "shield:DescribeProtection",
      "shield:CreateProtection",
      "shield:DeleteProtection"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateSecurityGroup"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateTags"
    ]

    resources = ["arn:aws:ec2:*:*:security-group/*"]

    condition {
      test     = "StringEquals"
      variable = "ec2:CreateAction"
      values = [
        "CreateSecurityGroup"
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]

    resources = ["arn:aws:ec2:*:*:security-group/*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:DeleteSecurityGroup"
    ]

    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateTargetGroup"
    ]

    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:CreateListener",
      "elasticloadbalancing:DeleteListener",
      "elasticloadbalancing:CreateRule",
      "elasticloadbalancing:DeleteRule"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]

    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
    ]

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["true"]
    }

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:AddTags",
      "elasticloadbalancing:RemoveTags"
    ]

    resources = [
      "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
      "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:SetIpAddressType",
      "elasticloadbalancing:SetSecurityGroups",
      "elasticloadbalancing:SetSubnets",
      "elasticloadbalancing:DeleteLoadBalancer",
      "elasticloadbalancing:ModifyTargetGroup",
      "elasticloadbalancing:ModifyTargetGroupAttributes",
      "elasticloadbalancing:DeleteTargetGroup",
      "elasticloadbalancing:ModifyListenerAttributes",
      "elasticloadbalancing:ModifyCapacityReservation",
      "elasticloadbalancing:ModifyIpPools"
    ]

    resources = ["*"]

    condition {
      test     = "Null"
      variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:AddTags"
    ]

    resources = [
      "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
      "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "elasticloadbalancing:CreateAction"
      values = [
        "CreateTargetGroup",
        "CreateLoadBalancer"
      ]
    }

    condition {
      test     = "Null"
      variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets"
    ]

    resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "elasticloadbalancing:SetWebAcl",
      "elasticloadbalancing:ModifyListener",
      "elasticloadbalancing:AddListenerCertificates",
      "elasticloadbalancing:RemoveListenerCertificates",
      "elasticloadbalancing:ModifyRule",
      "elasticloadbalancing:SetRulePriorities"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "aws_alb_controller_policy" {
  count       = var.alb_controller.enabled ? 1 : 0
  name        = "AWSLoadBalancerControllerIAMPolicy-${var.cluster_name}"
  description = "IAM Policy for AWS ALB Controller Kubernetes service account"
  policy      = data.aws_iam_policy_document.aws_alb_controller_policy_doc[0].json
}

## Assume Role Policy 

data "aws_iam_policy_document" "alb_controller_assume_role_irsa" {
  count   = var.alb_controller.enabled && var.enable_irsa ? 1 : 0
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
      values   = ["system:serviceaccount:${var.alb_controller.namespace}:${local.alb_sa_name}"]
    }
  }
}

data "aws_iam_policy_document" "alb_controller_assume_role_pod_identity" {
  count   = var.alb_controller.enabled && var.enable_irsa == false ? 1 : 0
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

resource "aws_iam_role" "aws_alb_controller_role_irsa" {
  count              = var.alb_controller.enabled && var.enable_irsa ? 1 : 0
  name               = "AWSLoadBalancerControllerIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.alb_controller_assume_role_irsa[0].json
}

resource "aws_iam_role" "aws_alb_controller_role_pod_identity" {
  count              = var.alb_controller.enabled && var.enable_irsa == false ? 1 : 0
  name               = "AWSLoadBalancerControllerIAMPolicyRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.alb_controller_assume_role_pod_identity[0].json
}

resource "aws_iam_role_policy_attachment" "aws_alb_controller_policy_rpa_irsa" {
  count      = var.alb_controller.enabled && var.enable_irsa ? 1 : 0
  role       = aws_iam_role.aws_alb_controller_role_irsa[0].name
  policy_arn = aws_iam_policy.aws_alb_controller_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "aws_alb_controller_policy_rpa_pod_identity" {
  count      = var.alb_controller.enabled && var.enable_irsa == false ? 1 : 0
  role       = aws_iam_role.aws_alb_controller_role_pod_identity[0].name
  policy_arn = aws_iam_policy.aws_alb_controller_policy[0].arn
}


resource "helm_release" "aws_alb_controller_irsa" {
  count      = var.alb_controller.enabled && var.enable_irsa ? 1 : 0
  name       = "aws-alb-controller"
  namespace  = var.alb_controller.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.alb_controller.chart_version

  set = [
    {
      name  = "clusterName"
      value = data.aws_eks_cluster.eks_cluster.name
    },
    {
      name  = "serviceAccount.create"
      value = var.alb_controller.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.alb_sa_name
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.aws_alb_controller_role_irsa[0].arn
    },
    {
      name  = "vpcId"
      value = data.aws_eks_cluster.eks_cluster.vpc_config[0].vpc_id
    },
    {
      name  = "region"
      value = data.aws_region.current.name
    },

  ]
}


resource "helm_release" "aws_alb_controller_pod_identity" {
  count      = var.alb_controller.enabled && var.enable_irsa == false ? 1 : 0
  name       = "aws-alb-controller"
  namespace  = var.alb_controller.namespace
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = var.alb_controller.chart_version

  depends_on = [kubernetes_namespace.kube_ops]

  set = [
    {
      name  = "clusterName"
      value = data.aws_eks_cluster.eks_cluster.name
    },
    {
      name  = "serviceAccount.create"
      value = var.alb_controller.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.alb_sa_name
    },
    {
      name  = "vpcId"
      value = data.aws_eks_cluster.eks_cluster.vpc_config[0].vpc_id
    },
    {
      name  = "region"
      value = data.aws_region.current.name
    },

  ]
}

resource "aws_eks_pod_identity_association" "aws_alb_controller" {
  count           = var.alb_controller.enabled && var.enable_irsa == false ? 1 : 0
  cluster_name    = data.aws_eks_cluster.eks_cluster.name
  namespace       = var.alb_controller.namespace
  service_account = local.alb_sa_name
  role_arn        = aws_iam_role.aws_alb_controller_role_pod_identity[0].arn
}
