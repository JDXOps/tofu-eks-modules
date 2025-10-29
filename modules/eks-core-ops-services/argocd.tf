resource "helm_release" "argocd" {
  count      = var.argocd.enabled ? 1 : 0
  name       = "argocd"
  namespace  = var.argocd.namespace
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd.chart_version
}
