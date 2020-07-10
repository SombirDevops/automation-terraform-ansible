variable "region" {
  type = string
  default = "us-central1"
}
variable "zone" {
  type = string
  default = "us-west1-a"
}
variable "vm_name_master" {
  type = string
  default = "k8s-master"
}
variable "vm_name_worker" {
  type = string
  default = "k8s-worker"
}
variable "machine_type" {
  type = string
  default = "n1-standard-1"
}
variable "ssh_username" {
  type = string
  default = "ubuntu"
}
variable "network_source_range" {
  type = list
  default = ["10.138.0.0/20"]
}
variable "ssh_pub_key_path" {
  type = string
  default = "/root/.ssh/id_rsa.pub"
}
variable "ssh_prv_key_path" {
  type = string
  default = "/root/.ssh/id_rsa"
}
