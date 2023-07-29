# Create the OCI VCN 
resource "oci_core_vcn" "vcn" {
  cidr_blocks    = var.vnc_cidr_block
  compartment_id = oci_identity_compartment.compartment.id
  is_ipv6enabled = false
  display_name   = "andrewkvasoff-appname-dev-vcn"
}
# Create the DHCP Options
resource "oci_core_dhcp_options" "dhcp" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "andrewkvasoff-appname-dev-dhcp-options"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

#  options {
#    type                = "SearchDomain"
#    search_domain_names = ["8.8.8.8"]
#  }
}
# Create the Internet Gateway
resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "andrewkvasoff-appname-dev-igw"
}
# Create a Route Table for the Internet Gateway
resource "oci_core_route_table" "igw_route_table" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "andrewkvasoff-appname-dev-igw-route-table"
  
  route_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
} 
# Create a Public Subnet
resource "oci_core_subnet" "public_subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.public_subnet_cidr_block
  display_name   = "andrewkvasoff-appname-dev-public-subnet"

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.public_security_list.id]
}
# Create a NAT Gateway
resource "oci_core_nat_gateway" "nat_gateway" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "andrewkvasoff-appname-dev-nat-gateway"
}
# Create a Route Table for the NAT Gateway
resource "oci_core_route_table" "nat_route_table" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "andrewkvasoff-appname-dev-nat-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }
}
# Create a Private Subnet
resource "oci_core_subnet" "private_subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.private_subnet_cidr_block
  display_name   = "${lower(replace(var.company," ","-"))}-${lower(replace(var.app_name," ","-"))}-${var.environment}-private-subnet"

  prohibit_public_ip_on_vnic = true

  route_table_id    = oci_core_route_table.igw_route_table.id
  dhcp_options_id   = oci_core_dhcp_options.dhcp.id
  security_list_ids = [oci_core_security_list.private_security_list.id]
}

