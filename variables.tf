
variable "rgname" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
  default     = "canadacentral"
}


variable "service_principal_name" {
  description = "Name of the service principal"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Azure Key Vault"
  type        = string
}
