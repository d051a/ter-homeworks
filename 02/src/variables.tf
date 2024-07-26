###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMnYTMCMHHzOhpVvA+uV28k9XpX1ntKf8GHI22YWdjAFdyn51+g/mNFKYkmOSYy4Q22gUTntbjHiKmUU4G19cb+5wlVcSbnaxiY2fezbS/lFjsOTxchyWRARR3mg0ek0/nolREZeVjzjdyd2YYEBFFAxhVn0cWhc0mnqrs/bIIQi/G24OgwFEGyr94U2myABa+WYLJJ3VSOJtTOsNjHhrLhYSbmZ4MRplijxkGBmJIdISTomlT0z/YpJ0YhgdIq7v/Nc1+fMJoimfaFOxrdH3yuRETszDnvsfEQ/zGTEkz98AjveG8SOK4p7RNDMhSkXcLuEIxIu3O688Zs/qgNUCgphScrqdj6cKyFD2CkQAfJDB93Ed6Wdzx5Ycj30mMxY/nItAna5NQhr02tt1ARupQRRmP2H5w81D3bdjdvBiN1IsWTbLDDr1IAH1lVNAWhVEYeqL62O/yvQgB4iwF7CVwEF1KRpDjCEdyAKMYXmnHkiFuO1utP6Lq3TRPuoHDSHs= alexandr@iWS14368.local"
  description = "ssh-keygen -t ed25519"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "develop"
}

variable "prefix" {
  description = "The prefix for the VM names"
  type        = string
  default     = "netology"
}


variable "vms_resources" {
  description = "Resources for the VMs"
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
}

variable "metadata" {
  description = "Metadata for the VMs"
  type = map(string)
}