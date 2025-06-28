variable "aws_admin_role_arn" {
  type        = string
  description = "The ARN of IAM Role that is to be granted admin access to the ETCD KMS encryption key."
}

variable "authentication_mode" {
  type        = string
  description = "The authentication mode to use to grant cluster users access. Valid values are 'API' or 'API_AND_CONFIG_MAP'."
  default     = "API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  description = "Boolean toggle to set whether or not the cluster creator IAM principle has cluster admin permissions"
  type        = string
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster."
}

variable "cluster_version" {
  type        = string
  description = "The EKS cluster version."
}

variable "enable_endpoint_private_access" {
  type        = bool
  description = "Boolean toggle to enable the EKS Private API server endpoint."
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  description = "List of enabled log types emitted by the control plane"
}

variable "public_access_cidrs" {
  description = "The CIDR to use for the AWS VPC."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "public_subnet_ids" {
  type        = list(string)
  description = "The public subnet IDs for your EKS cluster to use."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "The private subnet IDs for your EKS cluster to use."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources."
  default     = {}
}