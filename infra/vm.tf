# Получение образа Ubuntu 24.04
data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

# Виртуальная машина
resource "yandex_compute_instance" "kittygram_vm" {
  name        = var.vm_name
  hostname    = var.vm_name
  zone        = var.zone
  platform_id = var.platform_id

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      type     = var.disk_type
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram_subnet.id
    nat                = true  # Публичный IP
    security_group_ids = [yandex_vpc_security_group.kittygram_sg.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/init/vm-install.yml", {
      SSH_KEY = var.ssh_key
    })
  }
}
