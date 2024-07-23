terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.63"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = "b1gfm4iddgcs6q76dsmt"
  folder_id = "b1g1ga0o06suqc98dd8n"
}

resource "yandex_compute_instance" "vm" {
  name = "my-vm"
  zone = "ru-central1-a"

  resources {
    cores  = 1
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8n0i8gfl44vmr6tdcn"
    }
  }

  network_interface {
    subnet_id = "enp62j5bkr7k818cr5od"
    nat       = true
  }
}
