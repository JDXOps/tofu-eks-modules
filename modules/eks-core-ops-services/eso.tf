locals {
  eso_sa_name = "external-secrets"
}

resource "helm_release" "external_secrets_operator" {
  count      = var.eso.enabled ? 1 : 0
  name       = "external-secrets-operator"
  namespace  = var.eso.namespace
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  create_namespace = true 
  version    = var.eso.chart_version

  set = [
    {
        name =  "serviceAccount.create"
        value = var.eso.create_service_account
    },
    {
        name =  "serviceAccount.name"
        value = local.eso_sa_name
    },
    # {
    #     name =  "serviceAccount.annotations"
    #     value = var.eso.create_service_account
    # },
    ]
}
