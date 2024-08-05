resource "yandex_vpc_security_group" "default" {
  name       = var.security_group_name
  network_id = yandex_vpc_network.develop.id

  ingress {
    description = "allow http"
    protocol    = "TCP"
    port        = var.ingress_http_port
    v4_cidr_blocks = var.ingress_cidr_blocks
  }

  egress {
    description = "allow all"
    protocol    = "TCP"
    port        = var.egress_all_port
    v4_cidr_blocks = var.egress_cidr_blocks
  }
}

resource "yandex_compute_instance" "web" {
  count = var.web_instance_count

  depends_on = [yandex_compute_instance.db]

  name = "web-${count.index + 1}"

  resources {
    cores  = var.web_instance_cores
    memory = var.web_instance_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.default.id]
  }

  scheduling_policy {
    preemptible = var.web_instance_preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_path)}"
  }
}
