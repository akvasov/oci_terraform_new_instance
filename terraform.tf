terraform {
  cloud {
    organization = "example-org-46795e"

    workspaces {
      name = "oci-terraform-github-actions"
    }
  }
}


resource "null_resource" "example" {
       triggers = {
         value = "A example resource that does nothing!"
       }
     }


