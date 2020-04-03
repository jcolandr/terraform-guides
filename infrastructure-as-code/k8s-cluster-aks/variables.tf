variable "resource_group_name" {
  description = "Azure Resource Group Name"
}

variable "azure_location" {
  description = "Azure Location, e.g. North Europe"
  default = "East US"
}

variable "dns_prefix" {
  description = "DNS prefix for your cluster"
}

variable "cluster_name" {
  description = "name of aks cluster"
}

variable "k8s_version" {
  description = "Version of Kubernetes to use"
  default = "1.15.10"
}

variable "admin_user" {
  description = "Administrative username for the VMs"
  default = "azureuser"
}

variable "agent_pool_name" {
  description = "Name of the K8s agent pool"
  default = "default"
}

variable "agent_count" {
  description = "Number of agents to create"
  default = 3
}

variable "vm_size" {
  description = "Azure VM type"
  default = "Standard_D2"
}

variable "os_type" {
  description = "OS type for agents: Windows or Linux"
  default = "Linux"
}

variable "os_disk_size" {
  description = "OS disk size in GB"
  default = "30"
}

variable "environment" {

  description = "value passed to Environment tag and used in name of Vault k8s auth backend in the associated k8s-vault-config workspace"
  default = "aks-dev"
}

variable "vault_user" {
  description = "Vault userid: determines location of secrets and affects path of k8s auth backend that is created in the associated k8s-vault-config workspace"
}

variable "vault_addr" {
  description = "Address of Vault server including port that is used in the associated k8s-vault-config and k8s-services workspaces"
  default = "http://35.211.192.21:8200"
}

variable "address_space" {
  description = "network subnet of vnet"
}

variable "pod_cidr" {
  description = "The CIDR to use for pod IP addresses and within the address space of vnet"
}
variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service and within the address space of vnet"
}
variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)."
}

variable "node_subnet" {
  description = "subnet for nodes mus be within vnet address space"
}