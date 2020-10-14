variable "environment" {
  type = string
  default = "dev"
}

variable "client_secret" {
  type = string
  default = "xyz"
}

variable "resource_group_name" {
  type = string
  default = "rg-name"
}

provider "azurerm" {
  
  version = "2.5"
  features {}
#Get all the details from Azure active directory(App registration->overview page)
  client_id       = ""
  tenant_id       = ""
  subscription_id = "" 
  client_secret   = "${var.client_secret}"
}

provider "random" {
  version = "~> 2.2"
}

terraform {
  required_version = "0.12.16"

  backend "azurerm" {
    resource_group_name  = "rg-name"
    storage_account_name = "terraformStateFile"
    container_name       = "kafkaCluster"
    key                  = "Getkey from Azure storage"
  }
}

module "kafka" {
  source  = "./modules/azure-k8-kafka"
}