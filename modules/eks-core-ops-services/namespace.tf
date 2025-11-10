
locals {
  ops_namespace = "kube-ops"
}

resource "kubernetes_namespace" "kube_ops" {
  metadata {
    annotations = {
      createdBy = "terraform"
    }

    labels = {
      team = "devops"
    }

    name = local.ops_namespace
  }
}