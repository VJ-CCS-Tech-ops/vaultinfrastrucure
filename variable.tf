variable "inbound_port_ranges" {

  type    = list
  default = [22, 8200]
}

variable "region" {

  default = "uk south"
}

variable "vault_port" {

  default = 8200
}

variable "https_port" {

  default = 443
}

variable "vm_names" {

  type    = list
  default = ["Vault-VM01", "AzD-UKS-Vault-VM02"]
}
