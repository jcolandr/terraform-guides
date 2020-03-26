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
variable "servername" {
    description = "Server Name"
    default = "terraform-demo"
}


