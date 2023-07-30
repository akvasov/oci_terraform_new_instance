### oci_terraform_new_instance

Repo with Terraform files to create a new instance into Oracle Cloud Infrastructure
=======
Repo with Terraform files to create a new Compute instance of Oracle Cloud Infrastructure:
* provider-main.tf - OCI provider definition
* compartment.tf - creates a new compartment under administrator's parent compartment
* network-main.tf - creates VCN, Internet GW, NAT GW, Route tables for Internet/NAT GWs, Private and Public Subnets with DHCP address allocation
* security-lists.rf - creates Ingress/Egress acess rules for Private and Public Subnets
* compute.tf - creates Compute Instance with Ubuntu20.04 within FreeTier AD, assigns ephmemeral Public IP and starts nginx service on it
* install_scripts/buntu-initial-script.sh - shell script to start nginx service on a fresh Instance
* data.tf - shell script template file datasource to pass metadata variable into instance creation template

Note: terraform.tfvars file with Authentication, Network and Instance variables was added to .gitignore for security purpose
