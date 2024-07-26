

variable "vm_web_compute_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_compute_instance_cores" {
  type        = number
  default     = 2
}

variable "vm_web_compute_instance_memory" {
  type        = number
  default     = 1
}

variable "vm_web_compute_instance_fraction" {
  type        = number
  default     = 5
}



variable "vm_db_compute_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_db_compute_instance_cores" {
  type        = number
  default     = 2
}

variable "vm_db_compute_instance_memory" {
  type        = number
  default     = 1
}

variable "vm_db_compute_instance_fraction" {
  type        = number
  default     = 5
}

variable "vm_db_compute_instance_zone" {
  type        = string
  default     = "ru-central1-b"
}


