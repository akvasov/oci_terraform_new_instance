data "cloudinit_config" "ubuntu-initial-script" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("${path.module}/install_scripts/ubuntu-initial-script.sh",{})
  }
}
