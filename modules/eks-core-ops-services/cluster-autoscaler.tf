locals {
  cluster_autoscaler_sa_name = "cluster-autoscaler"
}


resource "helm_release" "cluster_autoscaler" {
  count = var.cluster_autoscaler.enabled ? 1 : 0
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.cluster_autoscler.chart_version


  set = [
    {
      name  = "autoDiscovery.clusterName"
      value = data.aws_eks_cluster.eks_cluster.name
    },
    {
      name  = "serviceAccount.create"
      value = var.cluster_autoscaler.create_service_account
    },
    {
      name  = "serviceAccount.name"
      value = local.cluster_autoscaler_sa_name
    },
  ]
}

## Set IAM Role and set Tags 