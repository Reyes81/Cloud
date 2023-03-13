# Para obtener información sobre la red externa
# Por ejemplo el id se podrá consultar así:
# ${data.openstack_networking_network_v2.external_network.id}
data "openstack_networking_network_v2" "external_network" {
  name = var.ext_net_name
}

# Creación de la red
resource "openstack_networking_network_v2" "network"{
  name = var.net_name
  admin_state_up = "true"
}

# Creación de la subred
resource "openstack_networking_subnet_v2" "subnetwork"{
  name = var.subnet_name
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr = var.cidr
  ip_version = 4
  dns_nameservers = ["8.8.8.8"]
}

# Creación del router y conexión al gateway (la red externa)
resource "openstack_networking_router_v2" "router"{
  name = var.router_name
  admin_state_up = "true"
  external_network_id = "${data.openstack_networking_network_v2.external_network.id}"
}

# Conexión del router a la subred
resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnetwork.id}"
}
