# VPC Network
resource "google_compute_network" "multi_cloud_vpc_network" {
    name                    = "${var.network_name}"
    routing_mode            = "GLOBAL"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "multicloud_private_subnet" {
    name                = "${var.priv_subnet_name}"
    ip_cidr_range       = "${var.priv_subnet_ip_cidr_range}"
    region              = "${var.region}"
    network             = google_compute_network.multi_cloud_vpc_network.id
}

resource "google_compute_subnetwork" "multicloud_public_subnet" {
    name                = "${var.pub_subnet_name}"
    ip_cidr_range       = "${var.pub_subnet_ip_cidr_range}"
    region              = "${var.region}"
    network             = google_compute_network.multi_cloud_vpc_network.id
}


resource "google_compute_address" "multicloud_static_ip" {
    name         = "${var.static_ip_name}"
    #network      = google_compute_network.multi_cloud_vpc_network.id
    #address_type = "EXTERNAL"
    region       = "${var.region}"
}


resource "google_compute_instance" "default" {
    name         = "${var.ping_instance_name}"
    machine_type = "f1-micro"
    zone         = "us-east1-b"

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-minimal-1604-lts"
        }
    }

    network_interface {
        subnetwork = google_compute_subnetwork.multicloud_private_subnet.id
    }
}

resource "google_compute_firewall" "ping_instance_firewall" {
    name    = "ping-firewall"
    network = google_compute_network.multi_cloud_vpc_network.id
    
    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
}