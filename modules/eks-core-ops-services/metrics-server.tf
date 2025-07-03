resource "helm_release" "metrics_server" {
  count      = var.metrics_server.enabled ? 1 : 0
  name       = "metrics-server"
  namespace  = var.metrics_server.namespace
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = var.metrics_server.chart_version
}
