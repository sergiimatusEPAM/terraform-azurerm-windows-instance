output "admin_username" {
  description = "SSH User"
  value       = "${module.dcos-windows-instances.admin_username}"
}

output "admin_password" {
  description = "Windows admin password"
  value       = "${module.dcos-windows-instances.admin_password}"
}

output "private_ips" {
  description = "List of private ip addresses created by this module"
  value       = ["${module.dcos-windows-instances.private_ips}"]
}

output "public_ips" {
  description = "List of public ip addresses created by this module"
  value       = ["${module.dcos-windows-instances.public_ips}"]
}
