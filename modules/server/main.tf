resource "openstack_compute_instance_v2" "server" {
  name            = var.server_name
  image_id        = "3fac1db8-c408-4f83-96e4-c5862a351af7"

  #openstack flavor list
  flavor_id       = "10522180-0fa9-4d83-be8b-250330bd4c0a"
  key_pair        = "claveproyecto4"
  security_groups = ["${openstack_compute_secgroup_v2.secgroup.name}"]

  metadata = {
    this = "that"
  }

  network {
    name = var.net_name
  }
}