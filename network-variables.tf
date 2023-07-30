# VCN Subnet CIDR
variable "vnc_cidr_block" {
  type        = list(string)
  description = "Virtual Cloud Network CIDR Block"
}

# Private Subnet CIDR
variable "private_subnet_cidr_block" {
  type        = string
  description = "Private Subnet CIDR Block"
}

# Public Subnet CIDR
variable "public_subnet_cidr_block" {
  type        = string
  description = "Public Subnet CIDR Block"
}
