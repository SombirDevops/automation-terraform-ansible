resource "google_compute_address" "k8s-master" {
  name = "ipv4-address-k8s-master"
}
resource "google_compute_address" "k8s-worker" {
  name = "ipv4-address-k8s-worker"
}
resource "google_compute_firewall" "k8s-default" {
 name    = "k8s-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["0-65535"]
 }
 source_ranges = ["10.138.0.0/20"]
 source_tags = ["web"]
 target_tags = ["${var.vm_name_master}-ssh", "k8s-cluster-firewall"]

}

resource "google_compute_firewall" "k8s-dashboard" {
 name    = "k8s-dashboard"
 network = "default"
 allow {
   protocol = "tcp"
   ports    = ["10443", "443", "80"]
 }
 source_ranges = ["0.0.0.0/0"]
 source_tags = ["dashboard"]
}

resource "google_compute_instance" "k8s-master" {
    name         = var.vm_name_master
    machine_type = var.machine_type
    zone         = var.zone
    tags         = ["${var.vm_name_master}-ssh"]

    boot_disk {
        initialize_params{
            image = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_key_path)}"
    }    
    
    network_interface {
      network = "default"
    access_config {
      nat_ip = google_compute_address.k8s-master.address
       }
    }
provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'",
    ]
connection {
    type        = "ssh"
    user        = var.ssh_username
    host        = google_compute_address.k8s-master.address
    private_key = file(var.ssh_prv_key_path)
  }
  }
provisioner "local-exec" {
    command = <<EOT
	  >k8s.ini;
	  echo "[k8s-master]" | tee -a k8s.ini;
	  echo "${google_compute_address.k8s-master.address}" | tee -a k8s.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -i ${google_compute_address.k8s-master.address}, -u ${var.ssh_username} k8s_cluster.yml -e "k8s_master_ip=${google_compute_address.k8s-master.address} k8s_master_private_ip=${google_compute_instance.k8s-master.network_interface.0.network_ip} k8s_worker_ip=${google_compute_address.k8s-worker.address}"
    EOT
  }
}

resource "google_compute_instance" "k8s-worker" {
    name         = var.vm_name_worker
    machine_type = var.machine_type
    zone         = var.zone
    tags         = ["k8s-cluster-firewall"]

    boot_disk {
        initialize_params{
            image = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }

    metadata = {
        ssh-keys = "${var.ssh_username}:${file(var.ssh_pub_key_path)}"
    }

    network_interface {
      network = "default"
    access_config {
      nat_ip = google_compute_address.k8s-worker.address
       }
    }
}
