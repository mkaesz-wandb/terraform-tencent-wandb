variable "region" {
  type        = string
  description = " region"
}

variable "zone" {
  type        = string
  description = " zone"
}

variable "namespace" {
  type        = string
  description = "Namespace prefix used for resources"
}

variable "domain_name" {
  type        = string
  description = "Domain name for accessing the Weights & Biases UI."
}

variable "subdomain" {
  type        = string
  description = "Subdomain for access the Weights & Biases UI."
}

variable "license" {
  type = string
}