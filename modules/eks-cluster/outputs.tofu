
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

output "cluster_ca_cert" {
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_oidc_issuer_url" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "cluster_secrets_key_arn" {
  value = aws_kms_key.eks_secrets_kms_key.arn
}