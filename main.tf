# Creación de red, subred y router
# See:
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_subnet_v2
#https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_v2  https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_router_interface_v2
#
module "networking"{
  source = "./modules/networking"
  ext_net_name = var.external_network_name
  net_name = var.network_name
  subnet_name = var.subnetwork_name
  router_name = var.router_name
}

# # Creación del grupo de seguridad
# # See:
 # https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_v2
module "secgroup"{
   source = "./modules/secgroup"
   sec_group_name = var.sec_group_name
 }

# # Creación de una regla en el grupo de seguridad
# # See:
# # https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2
  module "secgroup_rule_http"{
    source = "./modules/secgroup_rule"
    secgroup_id = module.secgroup.security_group_id
    port_ini = var.port_ini
    port_fin = var.port_fin
 }

# # Creación de un servidor con nginx en la red creada (donde estará el balanceador de carga)
# # See
# # https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
  module "server1" {
    source = "./modules/server"
    server_name = var.server1_name
    # flavor_name = var.flavor_name
    key_name = var.key_name
    user_data_file = var.user_data1_file
    net_name=var.network_name
    sec_group_name=var.sec_group_name
 }


# # Creación de un servidor con nginx en la red creada (donde estará el balanceador de carga)
# # See
# # https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
 module "server2" {
   source = "./modules/server"
   server_name = var.server2_name
   # flavor_name = var.flavor_name
   key_name = var.key_name
   user_data_file = var.user_data2_file
   net_name=var.network_name
   sec_group_name=var.sec_group_name
}

# # Creación de un servidor con nginx en la red creada (donde estará el balanceador de carga)
# # See
# # https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
 module "server3" {
   source = "./modules/server"
   server_name = var.server3_name
   # flavor_name = var.flavor_name
   key_name = var.key_name
   user_data_file = var.user_data3_file
   net_name=var.network_name
   sec_group_name=var.sec_group_name
}

# # Reservar una IP flotante para el proyecto:
# # See https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_floatingip_v2
  module "flotaing_ip" {
    source = "./modules/flotaing_ip"
    external_network_name=var.external_network_name
 }
