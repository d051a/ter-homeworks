# Определение переменных для виртуальных машин
variable "webservers" {
  description = "Список виртуальных машин для группы webservers"
  type = list(object({
    name           = string
    fqdn           = string
    network_interface = list(object({
      nat_ip_address = string
    }))
  }))
}

variable "databases" {
  description = "Список виртуальных машин для группы databases"
  type = list(object({
    name           = string
    fqdn           = string
    network_interface = list(object({
      nat_ip_address = string
    }))
  }))
}

variable "storage" {
  description = "Список виртуальных машин для группы storage"
  type = list(object({
    name           = string
    fqdn           = string
    network_interface = list(object({
      nat_ip_address = string
    }))
  }))
}

# Генерация инвентарного файла для Ansible
resource "local_file" "hosts_templatefile" {
  content  = templatefile("${path.module}/hosts.tftpl", {
    webservers = var.webservers
    databases  = var.databases
    storage    = var.storage
  })
  filename = "${abspath(path.module)}/hosts.cfg"
}
