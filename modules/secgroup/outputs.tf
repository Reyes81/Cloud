output "security_group_id" {
  value       = "${openstack_compute_secgroup_v2.secgroup.id}"
  description = "Id of the created secgroup"
}