output "vm_ip" {
  value = yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address
  description = "Public IP address of Kittygram VM"
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/kittygram yc-user@${yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address}"
  description = "SSH connection command"
}

output "kittygram_url" {
  value = "http://${yandex_compute_instance.kittygram_vm.network_interface[0].nat_ip_address}:9000"
  description = "Kittygram application URL"
}
