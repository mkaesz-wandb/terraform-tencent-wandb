variable "namespace" {
  type        = string
  description = "String used for prefix resources."
}

variable "region" {
  type        = string
  description = "Region."
}

variable "license" {
  type        = string
  description = "Your wandb/local license"
}

variable "domain_name" {
  type        = string
  default     = null
  description = "Domain for accessing the Weights & Biases UI."
}

variable "subdomain" {
  type        = string
  default     = null
  description = "Subdomain for accessing the Weights & Biases UI. Default creates record at Route53 Route."
}

