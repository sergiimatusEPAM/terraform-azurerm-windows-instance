/**
 * Azure DC/OS Windows Instances
 * ===================================
 * This module creates typical Windows instances.
 * _Beaware that this feature is in EXPERIMENTAL state_
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-windows-instances" {
 *   source  = "dcos-terraform/windows-instances/azure"
 *   version = "~> 0.0.1"
 *
 *   cluster_name = "production"
 *   subnet_id = "myid"
 *   security_group_ids = ["sg-12345678"]"
 *
 *   num = "2"
 *  ...
 *}
 *```
 */

provider "azurerm" {}

resource "random_string" "random_password" {
  length      = 32
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  min_special = 1
}

locals {
  password = "${random_string.random_password}"
}

// Instances is spawning the VMs to be used with DC/OS (bootstrap)
module "dcos-windows-instances" {
  source  = "dcos-terraform/instance/azurerm"
  version = "~> 0.2.0"

  providers = {
    azurerm = "azurerm"
  }

  num                               = "${var.num}"
  location                          = "${var.location}"
  cluster_name                      = "${var.cluster_name}"
  name_prefix                       = "${var.name_prefix}"
  vm_size                           = "${var.vm_size}"
  dcos_instance_os                  = "${var.dcos_instance_os}"
  ssh_private_key_filename          = "${var.ssh_private_key_filename}"
  image                             = "${var.image}"
  disk_type                         = "${var.disk_type}"
  disk_size                         = "${var.disk_size}"
  resource_group_name               = "${var.resource_group_name}"
  network_security_group_id         = "${var.network_security_group_id}"
  custom_data                       = "${var.custom_data}"
  admin_username                    = "${var.admin_username}"
  admin_password                    = "${local.password}"
  public_ssh_key                    = "${var.public_ssh_key}"
  tags                              = "${var.tags}"
  hostname_format                   = "${var.hostname_format}"
  subnet_id                         = "${var.subnet_id}"
  avset_platform_fault_domain_count = "${var.avset_platform_fault_domain_count}"
}
