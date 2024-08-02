resource "yandex_vpc_security_group" "default" {
  name       = "default-sg"
  network_id = yandex_vpc_network.develop.id

  ingress {
    description = "allow http"
    protocol    = "TCP"
    port       = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "allow all"
    protocol    = "TCP"
    port       = 0
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "web" {
  count = 2

  depends_on = [yandex_compute_instance.db]

  name = "web-${count.index + 1}"

  resources {
    cores  = 2
    memory = 2
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
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
