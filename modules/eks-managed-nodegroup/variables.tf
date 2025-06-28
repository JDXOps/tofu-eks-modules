variable "cluster_name" {
  type        = string
  description = "The EKS Cluster to attach the nodegroup(s) to."
}

variable "managed_nodegroups" {
  description = "Map of EKS managed node group configurations. Each entry defines settings like instance types, scaling, subnets, tags, and optional taints."
  type = map(object({
    node_group_name = string
    subnet_ids      = list(string)
    min_size        = number
    max_size        = number
    desired_size    = number
    ami_type        = string
    capacity_type   = string
    instance_types  = list(string)
    disk_size       = optional(number, 20)
    max_unavailable = optional(number, 1)
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
    labels = map(string)
    tags   = map(string)

  }))
  default = {}

}