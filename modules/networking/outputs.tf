output "subnet_id" {
  value       = "${openstack_networking_subnet_v2.subnetwork.id}"
  description = "Id of the created subnet"
}

output "net_id" {
  value       = "${openstack_networking_network_v2.network.id}"
  description = "Id of the created net"
}