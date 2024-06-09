variable "namespace" {
  type        = string
  description = "The name prefix for all resources created."
}

variable "vpc" {
  description = "VPC network to which the cluster is connected."
 # type        = object({ id = string })
}

variable "subnet" {
  description = "VPC subnet to which the cluster is connected."
#  type        = object({ id = string })
}