variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Folder ID"
  type        = string
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "kittygram-network"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "192.168.10.0/24"
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "vm-kittygram"
}

variable "platform_id" {
  description = "VM platform"
  type        = string
  default     = "standard-v3"
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM in GB"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-hdd"
}

variable "image_family" {
  description = "Image family"
  type        = string
  default     = "ubuntu-2404-lts"
}

variable "ssh_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}
