resource "yandex_compute_disk" "data_disks" {
  count = var.data_disk_count

  name   = "data-disk-${count.index + 1}"
  size   = var.data_disk_size
  type   = var.data_disk_type
}

resource "yandex_compute_instance" "storage" {
  name = var.storage_instance_name

  resources {
    cores  = var.storage_instance_cores
    memory = var.storage_instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.id
      size     = var.storage_boot_disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.default.id]
  }

  scheduling_policy {
    preemptible = var.storage_instance_preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
