variable "aks_cluster_name" {
  description = "The name of the Azure Kubernetes Service"
  type        = string
}

variable "location" {
  description = "The location of the Azure Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "client_id" {
  description = "The client ID of the service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret of the service principal"
  type        = string
}

variable "ssh_key" {
  description = "The path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}


