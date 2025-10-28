resource "helm_release" "kubecost" {
  count            = var.kubecost.enabled ? 1 : 0
  name             = "kubecost"
  namespace        = var.kubecost.namespace
  repository       = "https://kubecost.github.io/cost-analyzer/"
  chart            = "cost-analyzer"
  version          = var.kubecost.chart_version

  set = [    
        {
        name  = "global.clusterId"
        value = data.aws_eks_cluster.eks_cluster.name
        },
    # 🔴 Disable PVs for Prometheus
        {
        name  = "kubecostModel.persistentVolume.enabled"
        value = "false"
        },
        {
        name  = "prometheus.server.persistentVolume.enabled"
        value = "false"
        },
        # 🔴 Disable PV for Kubecost cost-analyzer cache
        # {
        # name  = "kubecostProductConfigs.persistentVolume.enabled"
        # value = "false"
        # }
    ]

}
