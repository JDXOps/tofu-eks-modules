resource "helm_release" "kube_prometheus_stack" {
  count            = var.kube_prometheus.enabled ? 1 : 0
  name             = "kube-prometheus"
  namespace        = var.kube_prometheus.namespace
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  create_namespace = true
  version          = var.kube_prometheus.chart_version

}
