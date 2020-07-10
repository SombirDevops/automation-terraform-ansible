resource "google_compute_address" "static" {
  name = "ipv4-address"
}
resource "google_compute_firewall" "default" {
 name    = "test-firewall"
 network = "default"

 allow {
   protocol = "tcp"
   ports    = ["80"]
 }
 source_ranges = var.source_network_ranges
 source_tags = ["web"]
 target_tags = ["${var.vm_name}-ssh"]

}

resource "google_compute_instance" "nginx" {
    name         = var.vm_name
    machine_type = var.machine_type
    zone         = var.zone
    tags         = ["${var.vm_name}-ssh"]

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
      nat_ip = google_compute_address.static.address
       }
    }
provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'",
    ]
connection {
    type     	= "ssh"
    user     	= var.ssh_username
    host     	= google_compute_address.static.address
    private_key = file(var.ssh_prv_key_path)
  }
  }
provisioner "local-exec" {
    command = <<EOT
	  >nginx.ini;
	  echo "[nginx]" | tee -a nginx.ini;
	  echo "${google_compute_address.static.address}" | tee -a nginx.ini;
      export ANSIBLE_HOST_KEY_CHECKING=False;
	  ansible-playbook -u ${var.ssh_username} -i nginx.ini nginx_passenger.yml -e 'passenger_server_name=${google_compute_address.static.address}'
    EOT
  }
}
