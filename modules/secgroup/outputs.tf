output "security_group_id" {
  value       = "${openstack_compute_secgroup_v2.secgroup.id}"
  description = "Id of the created secgroup"
}

output "security_group_name" {
  value       = "${openstack_compute_secgroup_v2.secgroup.name}"
  description = "Name of the created secgroup"
}