// A variable for extracting the external IP address of the instance
output "k8s-master-ip" {
 value = google_compute_instance.k8s-master.network_interface.0.access_config.0.nat_ip
}
output "k8s-worker-ip" {
 value = google_compute_instance.k8s-worker.network_interface.0.access_config.0.nat_ip
}
