terraform {
  required_version = ">= 0.11.11"
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

provider "vault" {
  address = "http://35.211.192.21:8200"
}

data "vault_generic_secret" "azure_credentials" {
  path = "secret/${var.vault_user}/azure/credentials"
}

provider "azurerm" {
  subscription_id = "${data.vault_generic_secret.azure_credentials.data["subscription_id"]}"
  tenant_id       = "${data.vault_generic_secret.azure_credentials.data["tenant_id"]}"
  client_id       = "${data.vault_generic_secret.azure_credentials.data["client_id"]}"
  client_secret   = "${data.vault_generic_secret.azure_credentials.data["client_secret"]}"
  features {}
}

# Azure Resource Group
resource "azurerm_resource_group" "k8sexample" {
  name     = "${var.resource_group_name}"
  location = "${var.azure_location}"
}


resource "azurerm_virtual_network" "k8sexample" {
  name                = "${var.dns_prefix}-network"
  location            = "${azurerm_resource_group.example.location}"
  resource_group_name = "${azurerm_resource_group.example.name}"
  address_space       = ["${var.address_space}"]
}

# Azure Container Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "k8sexample" {
  name = "${var.cluster_name}"
  location = "${azurerm_resource_group.k8sexample.location}"
  resource_group_name = "${azurerm_resource_group.k8sexample.name}"
  dns_prefix = "${var.dns_prefix}"
  kubernetes_version = "${var.k8s_version}"

  linux_profile {
    admin_username = "${var.admin_user}"
    ssh_key {
      key_data = "${chomp(tls_private_key.ssh_key.public_key_openssh)}"
    }
  }

  default_node_pool {
    name       = "${var.agent_pool_name}"
    node_count      =  "${var.agent_count}"
    # os_type    = "${var.os_type}"
    os_disk_size_gb = "${var.os_disk_size}"
    vm_size    = "${var.vm_size}"
  }
  
  network_profile {
    network_plugin = "kubenet"
    pod_cidr = "${var.pod_cidr}"
    service_cidr = "${var.service_cidr}"
    docker_bridge_cidr = "172.17.0.1/16"
    dns_service_ip = "${var.dns_service_ip}"
  }

  service_principal {
    client_id     = "${data.vault_generic_secret.azure_credentials.data["client_id"]}"
    client_secret = "${data.vault_generic_secret.azure_credentials.data["client_secret"]}"
  }

  tags {
    Environment = "${var.environment}"
  }
}
