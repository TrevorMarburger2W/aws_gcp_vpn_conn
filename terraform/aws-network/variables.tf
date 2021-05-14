variable "cust_gateway_ip_addr" {
  type        = string
  description = "Customer Gateway IPv4 Address."
}

variable "region" {
  type        = string
  description = "AWS Region."
}

variable "vpc_cidr_block" {
  type        = string
  description = "AWS VPC Cidr Range."
}

variable "vpc_pub_subnet_cidr_block" {
  type        = string
  description = "AWS Public Subnet Cidr Range."
}

variable "vpc_priv_subnet_cidr_block" {
  type        = string
  description = "AWS Private Subnet Cidr Range."
}