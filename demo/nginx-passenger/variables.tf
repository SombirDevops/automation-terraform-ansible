variable "project_name" {
  type = string
  default = "evident-syntax-282809"
}
variable "region" {
  type = string
  default = "us-central1"
}
variable "zone" {
  type = string
  default = "us-west1-a"
}
variable "vm_name" {
  type = string
  default = "nginx-passenger"
}
variable "machine_type" {
  type = string
  default = "f1-micro"
}
variable "ssh_username" {
  type = string
  default = "ubuntu"
}
variable "source_network_ranges" {
  type = list
  default = ["104.56.114.248/32", "198.144.216.128/32", "103.129.121.173/32", "192.195.81.38/32", "115.98.15.46/32"]
}
variable "ssh_pub_key_path" {
  type = string
  default = "/root/.ssh/id_rsa.pub"
}
variable "ssh_prv_key_path" {
  type = string
  default = "/root/.ssh/id_rsa"
}
