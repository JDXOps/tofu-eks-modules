
output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_ca_cert_data" {
  description = "The base64 encoded certificate data required to communicate with the cluster."
  value       = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OIDC provider"
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group that is provisioned by EKS"
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "cluster_secrets_key_arn" {
  description = "The ARN of the KMS key used to encrypt Kubernetes secrets"
  value       = aws_kms_key.eks_secrets_kms_key.arn
}

output "cluster_status" {
  description = "Status of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.status
}

output "oidc_provider_arn" {
  value       = length(aws_iam_openid_connect_provider.eks) > 0 ? aws_iam_openid_connect_provider.eks[0].arn : null
}

output "oidc_provider_url" {
  value       = length(aws_iam_openid_connect_provider.eks) > 0 ? aws_iam_openid_connect_provider.eks[0].url : null
}