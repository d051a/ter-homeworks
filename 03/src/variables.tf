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
  description = "VPC network&subnet name"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for compute instances"
}

variable "ssh_key_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to the SSH public key"
}

variable "security_group_name" {
  type        = string
  default     = "default-sg"
  description = "Name of the security group"
}

variable "ingress_http_port" {
  type        = number
  default     = 80
  description = "Ingress HTTP port"
}

variable "ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks for ingress rules"
}

variable "egress_all_port" {
  type        = number
  default     = 0
  description = "Egress port"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks for egress rules"
}

variable "web_instance_count" {
  type        = number
  default     = 2
  description = "Number of web instances"
}

variable "web_instance_cores" {
  type        = number
  default     = 2
  description = "Number of cores for web instances"
}

variable "web_instance_memory" {
  type        = number
  default     = 2
  description = "Memory size (GB) for web instances"
}

variable "web_instance_preemptible" {
  type        = bool
  default     = true
  description = "Whether the web instances are preemptible"
}

variable "data_disk_count" {
  type        = number
  default     = 3
  description = "Number of data disks"
}

variable "data_disk_size" {
  type        = number
  default     = 1
  description = "Size of each data disk (GB)"
}

variable "data_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Type of data disks"
}

variable "storage_instance_name" {
  type        = string
  default     = "storage"
  description = "Name of the storage instance"
}

variable "storage_instance_cores" {
  type        = number
  default     = 2
  description = "Number of cores for the storage instance"
}

variable "storage_instance_memory" {
  type        = number
  default     = 2
  description = "Memory size (GB) for the storage instance"
}

variable "storage_boot_disk_size" {
  type        = number
  default     = 20
  description = "Size of the boot disk for the storage instance (GB)"
}

variable "storage_instance_preemptible" {
  type        = bool
  default     = true
  description = "Whether the storage instance is preemptible"
}
