# Сеть VPC
resource "yandex_vpc_network" "kittygram_network" {
  name = var.vpc_name
}

# Подсеть (одна зона, как в задании)
resource "yandex_vpc_subnet" "kittygram_subnet" {
  name           = "${var.vpc_name}-subnet"
  zone           = var.zone
  v4_cidr_blocks = [var.subnet_cidr]
  network_id     = yandex_vpc_network.kittygram_network.id
}

# Группа безопасности (по требованиям задания)
resource "yandex_vpc_security_group" "kittygram_sg" {
  name        = "${var.vpc_name}-sg"
  description = "Security group for Kittygram"
  network_id  = yandex_vpc_network.kittygram_network.id

  # Исходящий трафик - весь разрешён
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  # Входящий SSH (порт 22)
  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "SSH"
  }

  # Входящий HTTP для gateway (порт 9000 по заданию)
  ingress {
    protocol       = "TCP"
    port           = 9000
    v4_cidr_blocks = ["0.0.0.0/0"]
    description    = "Kittygram gateway"
  }
}
