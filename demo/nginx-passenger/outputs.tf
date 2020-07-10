// A variable for extracting the external IP address of the instance
output "nginx_passenger_ip" {
 value = google_compute_instance.nginx.network_interface.0.access_config.0.nat_ip
}
