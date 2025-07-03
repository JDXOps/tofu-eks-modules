resource "aws_eks_addon" "pod_identity_agent" {
  count         = var.enable_eks_pod_identity ? 1 : 0
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = var.eks_pod_identity_version
}