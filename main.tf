terraform {
  cloud {
    organization = "brightblueray"

    workspaces {
      name = "idealco-compute-prod"
    }
  }
}

provider "azurerm" {
  features {}
}

data "tfe_outputs" "landingzone" {
  organization = "brightblueray"
  workspace = "idealco-landingzone-prod"
}

module "idealco_compute" {
  source  = "app.terraform.io/brightblueray/idealco_compute/azure"
  version = "1.0.0"
  # insert required variables here
  rg = data.tfe_outputs.landingzone.values.rg-name
  subnet_id = data.tfe_outputs.landingzone.values.subnet-id
}
