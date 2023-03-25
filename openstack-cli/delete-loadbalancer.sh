#!/bin/bash

####################################################################
#                                                                  #
# Script que borra todo lo relacionado con el balanceador de carga #
#                                                                  #
####################################################################

#Obtenemos los IDs necesarios para ejecutar los comandos
ID_port_balancer=`openstack port list|grep loadbalancer|cut -f2 -d'|'|cut -b2-`
ID_floating_ip=`openstack floating ip list|grep $ID_port_balancer|cut -f2 -d'|'|cut -b2-`
ID_monitor=`neutron lbaas-healthmonitor-list -f yaml | grep id | cut -f 2 -d ':'|cut -b2-`

#Obtenemos los ID de los miembros del pool
members=[]
i=0
for member in `neutron lbaas-pool-show proyecto4-pool -c members -f yaml|grep -v members|cut -b3-`
do
    members[$i]=$member
    ((i++))
done

echo ${members[0]}
echo ${members[1]}
echo ${members[2]}


#Quitamos las reglas de seguridad al puerto del balanceador
neutron port-update --no-security-group ${ID_port_balancer}
sleep 10

#Desasociacimos ID del puerto y el ID de la IP flotante
neutron floatingip-disassociate ${ID_floating_ip} ${ID_port_balancer}
sleep 10

#Eliminamos monitor
neutron lbaas-healthmonitor-delete ${ID_monitor}
sleep 10

#Eliminamos los miembros del pool
neutron lbaas-member-delete ${members[0]} proyecto4-pool
sleep 10

neutron lbaas-member-delete ${members[1]} proyecto4-pool
sleep 10

neutron lbaas-member-delete ${members[2]} proyecto4-pool
sleep 10

#Eliminamos el pool
neutron lbaas-pool-delete proyecto4-pool
sleep 10

#Eliminamos el listener
neutron lbaas-listener-delete proyecto4-listener
sleep 10

#Eliminamos el balanceador
neutron lbaas-loadbalancer-delete proyecto4-balanceador
sleep 10


