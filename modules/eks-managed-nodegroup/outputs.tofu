output "node_group_arns" {
  description = "Map of node group names to their ARNs"
  value = {
    for name, ng in aws_eks_node_group.eks_nodegroup :
    name => ng.arn
  }
}

## Test 
# output "node_group_names" {
#   description = "Map of node group names to their ARNs"
#     value = [
#     for ng in aws_eks_node_group.eks_nodegroup :
#     ng.node_group_name
# ]

# }

output "node_group_statuses" {
  description = "Map of node group names to their ARNs"
  value = {
    for name, ng in aws_eks_node_group.eks_nodegroup :
    name => ng.status
  }
}