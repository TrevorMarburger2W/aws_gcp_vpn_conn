variable "gcp_proj" {
    type        = string
    description = "GCP Project ID."
}

variable "network_name" {
    type        = string
    description = "VPC Network Name."
}

variable "pub_subnet_name" {
    type        = string
    description = "VPC Public Subnet Name."
}

variable "priv_subnet_name" {
    type        = string
    description = "VPC Private Subnet Name."
}

variable "static_ip_name" {
    type        = string
    description = "GCP Public Subnet External IP Address Name."
}

variable "region" {
    type        = string
    description = "GCP Region."
}

variable "default_zone" {
    type        = string
    description = "GCP Default Zone."
}

variable "priv_subnet_ip_cidr_range" {
    type        = string
    description = "GCP Private Subnet CIDR Range."
}

variable "pub_subnet_ip_cidr_range" {
    type        = string
    description = "GCP Private Subnet CIDR Range."
}

variable "ping_instance_name" {
    type        = string
    description = "GCP Public Subnet EC2 Ping Instance."
}
