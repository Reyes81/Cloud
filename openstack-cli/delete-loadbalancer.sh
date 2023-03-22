#!/bin/bash

####################################################################
#                                                                  #
# Script que borra todo lo relacionado con el balanceador de carga #
#                                                                  #
####################################################################


#while read file;
#do
#    var=`echo $file | grep -q "loadbalancer"`
#    if [[ $var -eq 0 ]]
#    then
#    ID_port=`cut -f1 -d '' $var` 
#    fi
#done < openstack port list
ID_port=`echo $(openstack port list -c ID -f value ) | cut -d ' ' -f6`

echo ${ID_port}

#ID_port=$(openstack port list -c ID -f value)
#echo ${ID_port}
#Quitamos las reglas de seguridad al puerto del balanceador
#neutron port-update --no-security-group d531d833-a05a-46d4-864e-1b38063677e7
#sleep 1

#Desasociacimos ID del puerto y el ID de la IP flotante
#neutron floatingip-disassociate 7beebe88-10ae-4b8f-ac68-e954515ec239 d531d833-a05a-46d4-864e-1b38063677e7
#sleep 1

#Eliminamos monitor
#neutron lbaas-healthmonitor-delete 22e00bdb-42c3-4dc0-869b-56fbb34fa7fc
#sleep 1

#Eliminamos los miembros del pool
#neutron lbaas-member-delete 54f94e35-0aa5-485e-a509-c2b09bb5077a
#sleep 1

#neutron lbaas-member-delete 695877ee-02a6-4080-9f48-c10a4be24395
#sleep 1

#neutron lbaas-member-delete d1402a3a-8411-4644-9d79-0428bc917992
#sleep 1

#Eliminamos el pool
#neutron lbaas-pool-delete proyecto4-pool
#sleep 1

#Eliminamos el listener
#neutron lbaas-listener-delete proyecto4-listener
#sleep 1

#Eliminamos el balanceador
#neutron lbaas-loadbalancer-delete proyecto4-balanceador
#sleep 1


