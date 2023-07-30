#############################
#### Instance - Variables ###
#############################

# OS profile(CPU,RAM)
variable "os_shape" {
  type        = string
  description = "This variable defines instance profile to install"
}

# image OCID
variable "os_image_id" {
  type        = string
  description = "This variable defines OCID for the image to install"
}
# SSH Public key for VM access
variable "path_local_public_key" {
  default = "~/.ssh/id_rsa.pub"
  sensitive = true
}
