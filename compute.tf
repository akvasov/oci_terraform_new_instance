resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[2].name
    compartment_id = oci_identity_compartment.compartment.id
    shape = var.os_shape
    source_details {
        source_id = var.os_image_id 
        source_type = "image"
    }

    # Optional
    display_name = "Ubuntu instance 1"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.public_subnet.id 
    }
    metadata = {
        ssh_authorized_keys = file(var.path_local_public_key)
        "user_data"         = data.cloudinit_config.ubuntu-initial-script.rendered
    } 
    preserve_boot_volume = false
}
