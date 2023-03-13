#Creacion del grupo de seguridad con reglas
resource "openstack_compute_secgroup_v2" "secgroup" {
  name        = var.sec_group_name
  description = "Created secgroup"
}