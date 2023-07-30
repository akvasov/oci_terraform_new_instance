# Create the OCI Compartment
resource "oci_identity_compartment" "compartment" {
  compartment_id = var.oci_root_compartment
  description    = "Compartment for test resources"
  name           = "andrewkvasoff-appname-dev"
  enable_delete  = true
}
