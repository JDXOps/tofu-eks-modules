variable "cluster_name" {
  type        = string
  description = "The name of EKS Cluster to install core operational services to."
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC provider used for IRSA."
  type        = string
  default     = null
}

variable "alb_controller" {
  description = "Map to specify the AWS ALB Controller Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })
}

variable "metrics_server" {
  description = "Map to specify the Metrics Server Config"
  type = object({
    enabled       = optional(bool)
    chart_version = string
    namespace     = string
  })

}

variable "cluster_autoscaler" {
  description = "Map to specify the Cluster Autoscaler Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })

}

variable "kubecost" {
  description = "Map to specify the Kubecost Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })

}

variable "eso" {
  description = "Map to specify the External Secrets Operator Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })

}

variable "argocd" {
  description = "Map to specify the ArgoCd Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })

}

variable "ebs_csi_driver" {
  description = "Map to specify the ArgoCd Config"
  type = object({
    enabled                = optional(bool)
    chart_version          = string
    create_service_account = optional(bool)
    namespace              = string
  })

}

variable "ebs_csi_driver_addon" {
  description = "Map to specify the EBS CSI Driver EKS addon config"
  type = object({
    enabled = optional(bool)
    version = string
    # create_service_account = optional(bool)
    namespace = string
  })

}

# variable "kube_prometheus" {
#   description = "Map to specify the Kube Prometheus config"
#   type = object({
#     enabled                = optional(bool)
#     chart_version          = string
#     create_service_account = optional(bool)
#     namespace              = string
#   })
# }

variable "enable_irsa" {
  description = "Boolean to specify is IRSA is enabled"
  default     = false
}