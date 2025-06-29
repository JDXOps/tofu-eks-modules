output "fargate_profile_arns" {
  description = "Map of Fargate Profile names to their ARNs"
  value = {
    for name, ng in aws_eks_fargate_profile.fargate_profile :
    name => ng.arn
  }
}

output "fargate_profile_statuses" {
  description = "Map of Fargate Profile statuses to their ARNs"
  value = {
    for name, ng in aws_eks_fargate_profile.fargate_profile :
    name => ng.status
  }
}