# EKS Core Services

This module provisions a **essential system components for EKS** using Helm with  [OpenTofu](https://opentofu.org/). It supports common operational workloads such as **cluster scaling, metrics and log collection, ingress management and secrets management**.


## 🔐 Key Features

This module deploys the following core components to your EKS cluster:

- **Cluster Autoscaler** – Automatically scales node groups based on workload demand.
- **AWS Load Balancer Controller** – Manages AWS ALBs/NLBs for Kubernetes Ingress resources.



## 🔐 Key Components

- 🧱 **Cluster Autoscaler**: to scale node groups based on workload demand.
- 📦 **AWS Load Balancer Controller** to manage AWS Load Balancers for Kubernetes Ingress resources
- 📊 **Metrics Server** for Horizontal pod scaling pipelines (Horizontal Pod Autoscaler)

## ✅ TODO 

- [ ] External Secrets Operator
- [ ] Kube Prometheus Stack for monitoring, alerting and Grafana Dashbaords 


<!-- BEGIN_TF_DOCS -->
## Requirements
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 3.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.aws_alb_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.aws_alb_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.cluster_autoscaler_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_alb_controller_policy_rpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler_rpa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [helm_release.aws_alb_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_openid_connect_provider.oidc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.alb_controller_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_alb_controller_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_controller"></a> [alb\_controller](#input\_alb\_controller) | Map to specify the AWS ALB Controller Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_autoscaler"></a> [cluster\_autoscaler](#input\_cluster\_autoscaler) | Map to specify the Cluster Autoscaler Config | <pre>object({<br>    enabled                = optional(bool)<br>    chart_version          = string<br>    create_service_account = optional(bool)<br>    namespace              = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of EKS Cluster to install core operational services to. | `string` | n/a | yes |
| <a name="input_metrics_server"></a> [metrics\_server](#input\_metrics\_server) | Map to specify the Metrics Server Config | <pre>object({<br>    enabled       = optional(bool)<br>    chart_version = string<br>    namespace     = string<br>  })</pre> | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC provider used for IRSA. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->