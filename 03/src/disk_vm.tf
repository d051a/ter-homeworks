# Создание трех дисков с использованием count
resource "yandex_compute_disk" "data_disks" {
  count = 3

  name   = "data-disk-${count.index + 1}"
  size   = 1 # Размер диска в ГБ
  type   = "network-hdd" # Тип диска
}

# Создание виртуальной машины с именем "storage"
resource "yandex_compute_instance" "storage" {
  name = "storage"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.id
      size     = 20 # Размер boot-диска
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.default.id]
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}

