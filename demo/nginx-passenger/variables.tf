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
  default = ["0.0.0.0/0"]
}
variable "ssh_pub_key_path" {
  type = string
  default = "/root/.ssh/id_rsa.pub"
}
variable "ssh_prv_key_path" {
  type = string
  default = "/root/.ssh/id_rsa"
}
