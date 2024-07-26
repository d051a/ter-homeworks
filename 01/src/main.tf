terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.63"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}


resource "yandex_compute_instance" "vm" {
  name = "my-vm"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8n0i8gfl44vmr6tdcn"
    }
  }

  network_interface {
    subnet_id = "e9bm10dqkveh781oh7g9"
    nat       = true
  }

  metadata = {
    ssh-keys              = "debian:${file("~/.ssh/id_rsa.pub")}"
    serial-port-enable    = "0"
    install-unified-agent = "0"
    user_data = <<-EOF
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no
      users:
      - name: debian
        groups: sudo
        sudo: ALL=(ALL) NOPASSWD:ALL
        shell: /bin/bash
        ssh_authorized_keys:
        - ${file("~/.ssh/id_rsa.pub")}
      runcmd:
        - apt-get update
        - apt-get install -y \
            ca-certificates \
            curl \
            gnupg \
            lsb-release \
            docker.io
        - systemctl enable docker
        - systemctl start docker
      EOF
  }
}

resource "null_resource" "wait_for_docker" {
  provisioner "local-exec" {
    command = <<-EOT
      until ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no debian@${yandex_compute_instance.vm.network_interface[0].nat_ip_address} "sudo docker info" >/dev/null 2>&1; do
        echo "Waiting for Docker to start..."
        sleep 10
      done
      echo "Docker is up and running."
    EOT
  }

  depends_on = [yandex_compute_instance.vm]
}

resource "docker_image" "mysql" {
  name = "mysql:latest"
  provider = docker
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql"
  ports {
    internal = 3306
    external = 3306
  }
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.mysql_root_password.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.mysql_password.result}",
    "MYSQL_ROOT_HOST=%"
  ]
  provider = docker
}

resource "random_password" "mysql_root_password" {
  length  = 16
  special = true
}

resource "random_password" "mysql_password" {
  length  = 16
  special = true
}

output "vm_ip_address" {
  value = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

