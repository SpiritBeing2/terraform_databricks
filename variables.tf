variable "resource_group_name" {
  type        = string
  description = "Nom du Resource Group"
}

variable "resource_group_vault" {
  type        = string
  description = "Nom du Resource Group Contenant le Vault"
}

variable "location" {
  type        = string
  description = "Région Azure"
  default     = "France Central"
}

variable "vault_name" {
  type        = string
  description = "Name of Azure KV store"
}
