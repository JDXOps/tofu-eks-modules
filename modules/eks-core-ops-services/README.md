## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0.2 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_pod_identity_association.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_eks_pod_identity_association.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_eks_pod_identity_association.eso_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_eks_pod_identity_association.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_pod_identity_association) | resource |
| [aws_iam_policy.aws_alb_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.eso_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_dns_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_alb_controller_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.aws_alb_controller_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_autoscaler_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_autoscaler_role_irsa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ebs_csi_driver_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ebs_csi_driver_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eso_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eso_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.external_dns_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.external_dns_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_alb_controller_policy_rpa_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_alb_controller_policy_rpa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler_rpa_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler_rpa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ebs_csi_driver_rpa_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ebs_csi_driver_rpa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eso_rpa_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eso_rpa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_dns_rpa_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_dns_rpa_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.aws_alb_controller_irsa](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.aws_alb_controller_pod_identity](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler_irsa](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler_pod_identity](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ebs_csi_driver](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external_dns](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external_secrets_operator](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.external_secrets_operator_pod_identity](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace.kube_ops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.oidc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy.ebs_csi_driver_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.alb_controller_assume_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.alb_controller_assume_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_alb_controller_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_assume_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_assume_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs_csi_driver_assume_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs_csi_driver_assume_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eso_assume_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eso_assume_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eso_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns_assume_role_irsa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns_assume_role_pod_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_controller"></a> [alb\_controller](#input\_alb\_controller) | Map to specify the AWS ALB Controller Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_argocd"></a> [argocd](#input\_argocd) | Map to specify the ArgoCd Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_autoscaler"></a> [cluster\_autoscaler](#input\_cluster\_autoscaler) | Map to specify the Cluster Autoscaler Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of EKS Cluster to install core operational services to. | `string` | n/a | yes |
| <a name="input_ebs_csi_driver"></a> [ebs\_csi\_driver](#input\_ebs\_csi\_driver) | Map to specify the ArgoCd Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Boolean to specify is IRSA is enabled | `bool` | `false` | no |
| <a name="input_eso"></a> [eso](#input\_eso) | Map to specify the External Secrets Operator Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_external_dns"></a> [external\_dns](#input\_external\_dns) | Map to specify the ExternalDNS Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_kubecost"></a> [kubecost](#input\_kubecost) | Map to specify the Kubecost Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server) | Map to specify the Metrics Server Config | <pre>object({<br>    enabled       = optional(bool)<br>    chart_version = string<br>    namespace     = string<br>  })</pre> | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC provider used for IRSA. | `string` | `null` | no |

## Outputs

No outputs.
