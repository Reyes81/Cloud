#!/bin/bash

###################################################################
#                                                                 #
# Script que crea todo lo relacionado con el balanceador de carga #
#                                                                 #
###################################################################

#Obtenemos los ID de los miembros del pool
IP_servers=[]
i=0
for ip_server in `openstack server list -c Networks -f yaml|cut -c 36-`
do
    IP_servers[$i]=$ip_server
    ((i++))
done

#Creamos el balanceador de carga                                  
neutron lbaas-loadbalancer-create --name proyecto4-balanceador proyecto4-subnetwork-lab2
sleep 15

#Obtenemos los IDs necesarios para ejecutar los comandos
ID_port_balancer=`openstack port list|grep loadbalancer|cut -f2 -d'|'|cut -b2-`
#ID_floating_ip=`openstack floating ip list|grep $ID_port_balancer|cut -f2 -d'|'|cut -b2-`
ID_floating_ip=7beebe88-10ae-4b8f-ac68-e954515ec239
sleep 15

echo "Teeeeest"
echo ${ID_port_balancer}
echo ${ID_floating_ip}
echo ${IP_servers[0]}
echo ${IP_servers[1]}
echo ${IP_servers[2]}

#Creamos el listener
neutron lbaas-listener-create --name proyecto4-listener --loadbalancer proyecto4-balanceador --protocol HTTP --protocol-port 80
sleep 15

#Creamos el pool 
neutron lbaas-pool-create --name proyecto4-pool --lb-algorithm ROUND_ROBIN --listener proyecto4-listener --protocol HTTP
sleep 15

#Añadimos cada uno de los nodos sobre los que vamos a realizar el balanceo
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address ${IP_servers[0]} --protocol-port 80 proyecto4-pool
sleep 5
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address ${IP_servers[1]} --protocol-port 80 proyecto4-pool
sleep 5
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address ${IP_servers[2]} --protocol-port 80 proyecto4-pool
sleep 5


#Creamos un monitor y lo asociamos al pool
neutron lbaas-healthmonitor-create --delay 5 --type HTTP --max-retries 3 --timeout 2 --pool proyecto4-pool
sleep 5

#Asociación ID del puerto y el ID de la IP flotante
neutron floatingip-associate ${ID_floating_ip} ${ID_port_balancer}
sleep 5

#Aplicamos las reglas de seguridad al puerto del balanceador
neutron port-update --security-group proyecto4-security-group-lab2 ${ID_port_balancer}
sleep 5