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
| [aws_eks_node_group.eks_nodegroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_role.eks_node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.eks_assume_node_role_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The EKS Cluster to attach the nodegroup(s) to. | `string` | n/a | yes |
| <a name="input_managed_nodegroups"></a> [managed\_nodegroups](#input\_managed\_nodegroups) | Map of EKS managed node group configurations. Each entry defines settings like instance types, scaling, subnets, tags, and optional taints. | <pre>map(object({<br>    node_group_name = string<br>    subnet_ids      = list(string)<br>    min_size        = number<br>    max_size        = number<br>    desired_size    = number<br>    ami_type        = string<br>    capacity_type   = string<br>    instance_types  = list(string)<br>    disk_size       = optional(number, 20)<br>    max_unavailable = optional(number, 1)<br>    taints = optional(list(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    })), [])<br>    labels = map(string)<br>    tags   = map(string)<br><br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_node_group_arns"></a> [node\_group\_arns](#output\_node\_group\_arns) | Map of node group names to their ARNs |
| <a name="output_node_group_statuses"></a> [node\_group\_statuses](#output\_node\_group\_statuses) | Map of node group names to their ARNs |
<!-- END_TF_DOCS -->