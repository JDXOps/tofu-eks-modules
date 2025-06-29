# EKS Control Plane Terraform Module

This module provisions a **secure, production-ready Amazon EKS (Elastic Kubernetes Service) control plane** using [OpenTofu](https://opentofu.org/) or Terraform.

## 🔐 Key Features

- 🛡️ **Envelope encryption** of Kubernetes Secrets using AWS KMS and `encryption_config`
- 🔐 **Granular KMS key policy** for least-privilege access by the EKS control plane and an admin IAM role
- 📦 **Fully parameterized** for reusable multi-environment deployments (dev, staging, prod, etc.)
- 📊 **Control plane logging** via CloudWatch
- 🧱 **IAM role creation**, secure assume-role policy, and VPC integration

## ✅ Use Cases

- Bootstrap a secure EKS cluster as the foundation of a cloud-native platform
- Integrate with GitOps (e.g., Argo CD) and CI/CD (e.g., GitHub Actions)
- Apply modern security practices with managed secrets and minimal IAM permissions


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_kms_key.eks_secrets_kms_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_iam_policy_document.eks_assume_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.eks_kms_policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/4.1.0/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_mode"></a> [authentication\_mode](#input\_authentication\_mode) | The authentication mode to use to grant cluster users access. Valid values are 'API' or 'API\_AND\_CONFIG\_MAP'. | `string` | `"API_AND_CONFIG_MAP"` | no |
| <a name="input_aws_admin_role_arn"></a> [aws\_admin\_role\_arn](#input\_aws\_admin\_role\_arn) | The ARN of IAM Role that is to be granted admin access to the ETCD KMS encryption key. | `string` | n/a | yes |
| <a name="input_bootstrap_cluster_creator_admin_permissions"></a> [bootstrap\_cluster\_creator\_admin\_permissions](#input\_bootstrap\_cluster\_creator\_admin\_permissions) | Boolean toggle to set whether or not the cluster creator IAM principle has cluster admin permissions | `string` | `false` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | The EKS cluster version. | `string` | n/a | yes |
| <a name="input_enable_endpoint_private_access"></a> [enable\_endpoint\_private\_access](#input\_enable\_endpoint\_private\_access) | Boolean toggle to enable the EKS Private API server endpoint. | `bool` | n/a | yes |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Boolean toggle to enable IAM Roles for Service Accounts (IRSA) | `bool` | `false` | no |
| <a name="input_enabled_cluster_log_types"></a> [enabled\_cluster\_log\_types](#input\_enabled\_cluster\_log\_types) | List of enabled log types emitted by the control plane | `list(string)` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The private subnet IDs for your EKS cluster to use. | `list(string)` | n/a | yes |
| <a name="input_public_access_cidrs"></a> [public\_access\_cidrs](#input\_public\_access\_cidrs) | The CIDR to use for the AWS VPC. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | The public subnet IDs for your EKS cluster to use. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The ARN of the EKS cluster |
| <a name="output_cluster_ca_cert_data"></a> [cluster\_ca\_cert\_data](#output\_cluster\_ca\_cert\_data) | The base64 encoded certificate data required to communicate with the cluster. |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Kubernetes API server endpoint |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OIDC provider |
| <a name="output_cluster_secrets_key_arn"></a> [cluster\_secrets\_key\_arn](#output\_cluster\_secrets\_key\_arn) | The ARN of the KMS key used to encrypt Kubernetes secrets |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | ID of the cluster security group that is provisioned by EKS |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | n/a |
| <a name="output_oidc_provider_url"></a> [oidc\_provider\_url](#output\_oidc\_provider\_url) | n/a |
<!-- END_TF_DOCS -->