variable "vsphere_server" {
    description = "vsphere server for the environment - EXAMPLE: vcenter01.hosted.local"
    default = "10.100.0.3"
}
variable "vsphere_user" {
    description = "vsphere server for the environment - EXAMPLE: vsphereuser"
    default = "administrator@vsphere.local"
}
variable "vsphere_password" {
    description = "vsphere server password for the environment"
}

variable "vsphere_pg_name" {
    description = "standard vm port group vsphere_pg_name"
    default = "WCPG"
}

