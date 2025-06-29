variable "cluster_name" {
  type        = string
  description = "The EKS Cluster to attach the nodegroup(s) to."
}

variable "fargate_profiles" {
  description = "Map of EKS Fargate profile configurations. Each entry defines settings like subnets and selectors"
  type = map(object({
    profile_name = string
    subnet_ids   = list(string)
    selectors = optional(list(object({
      namespace = string
      labels    = optional(map(string))
    })), [])

    tags = map(string)

  }))
  default = {}

}