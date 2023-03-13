resource "openstack_networking_secgroup_rule_v2" "secgroup_rule" {

  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    =  var.port_ini
  port_range_max    =  var.port_fin
  security_group_id = var.secgroup_id
}