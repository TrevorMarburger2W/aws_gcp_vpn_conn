# Resource:
# https://medium.com/peek-travel/connecting-an-aws-and-gcp-vpc-using-an-ipsec-vpn-tunnel-with-bgp-f332c2885975

resource "aws_vpc" "multicloud_vpc" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"
}

resource "aws_subnet" "multicloud_private_subnet" {
  vpc_id      = aws_vpc.multicloud_vpc.id
  cidr_block  = "${var.vpc_priv_subnet_cidr_block}" # 10.0.0.0/24
}

resource "aws_subnet" "multicloud_public_subnet" {
  vpc_id      = aws_vpc.multicloud_vpc.id
  cidr_block  = "${var.vpc_pub_subnet_cidr_block}"
}

resource "aws_customer_gateway" "multicloud_cust_gw" {
  bgp_asn    = 65000
  ip_address = "${var.cust_gateway_ip_addr}"
  type       = "ipsec.1"
}

resource "aws_vpn_gateway" "multicloud_vpn_gw" {
  vpc_id = aws_vpc.multicloud_vpc.id
}

resource "aws_vpn_connection" "multicloud_vpn_conn" {
  vpn_gateway_id      = aws_vpn_gateway.multicloud_vpn_gw.id
  customer_gateway_id = aws_customer_gateway.multicloud_cust_gw.id
  type                = "ipsec.1"
  static_routes_only  = true
}

resource "aws_vpn_connection_route" "gcp_priv_subnet" {
  destination_cidr_block = "10.142.11.0/28" # GCP Private Subnet CIDR
  vpn_connection_id      = aws_vpn_connection.multicloud_vpn_conn.id
}

# Security
resource "aws_security_group" "allow_ssh_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.multicloud_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.multicloud_vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# Compute
resource "aws_instance" "ping-instance" {
  ami           = "ami-0ee02acd56a52998e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.multicloud_private_subnet.id
}