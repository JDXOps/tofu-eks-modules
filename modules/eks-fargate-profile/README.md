# EKS Fargate Profiles

This module provisions a EKS Fargate profiles using [OpenTofu](https://opentofu.org/).

## 🔐 Key Features

- 🧱 **Flexible Integration**.  Integrate the Fargate profiles in this module with any EKS cluster
- 🔐 **Pod Execution Role** to enable Fargate Nodes to interact with AWS APIs for core functionality like pulling images from ECR.
- 📦 **Fully parameterized** for reusable multi-environment deployments (dev, staging, prod, etc.)

## ✅ Use Cases

- Add 'serverless' Fargate nodes to an EKS cluster.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_fargate_profile.fargate_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_fargate_profile) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The EKS Cluster to attach the nodegroup(s) to. | `string` | n/a | yes |
| <a name="input_fargate_profiles"></a> [fargate\_profiles](#input\_fargate\_profiles) | Map of EKS Fargate profile configurations. Each entry defines settings like subnets and selectors | <pre>map(object({<br>    subnet_ids = list(string)<br>    selectors = optional(list(object({<br>      namespace = string<br>      labels    = optional(map(string))<br>    })), [])<br><br>    tags = map(string)<br><br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fargate_profile_arns"></a> [fargate\_profile\_arns](#output\_fargate\_profile\_arns) | Map of Fargate Profile names to their ARNs |
| <a name="output_fargate_profile_statuses"></a> [fargate\_profile\_statuses](#output\_fargate\_profile\_statuses) | Map of Fargate Profile statuses to their ARNs |
<!-- END_TF_DOCS -->