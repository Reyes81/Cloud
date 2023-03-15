resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = var.external_network_name
}
