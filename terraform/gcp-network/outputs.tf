output "gcp_vpc_id" {
    description = "ID of the VPC."
    value       = google_compute_network.multi_cloud_vpc_network.id
}
/*
output "gcp_external_ip" {
    description = "Public Subnet IPv4 Address."
    value       = google_compute_address.multicloud_static_ip.address
}
*/