#!/bin/bash

###################################################################
#                                                                 #
# Script que crea todo lo relacionado con el balanceador de carga #
#                                                                 #
###################################################################


#Creamos el balanceador de carga                                  
neutron lbaas-loadbalancer-create --name proyecto4-balanceador proyecto4-subnetwork-lab2
sleep 1

#Creamos el listener
neutron lbaas-listener-create --name proyecto4-listener --loadbalancer proyecto4-balanceador --protocol HTTP --protocol-port 80
sleep 1

#Creamos el pool 
neutron lbaas-pool-create --name proyecto4-pool --lb-algorithm ROUND_ROBIN --listener proyecto4-listener --protocol HTTP
sleep 1

#Añadimos cada uno de los nodos sobre los que vamos a realizar el balanceo
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address 10.40.20.7 --protocol-port 80 proyecto4-pool
sleep 1
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address 10.40.20.14 --protocol-port 80 proyecto4-pool
sleep 1
neutron lbaas-member-create --subnet proyecto4-subnetwork-lab2 --address 10.40.20.6 --protocol-port 80 proyecto4-pool
sleep 1

#Creamos un monitor y lo asociamos al pool
neutron lbaas-healthmonitor-create --delay 5 --type HTTP --max-retries 3 --timeout 2 --pool proyecto4-pool
sleep 1

#Asociación ID del puerto y el ID de la IP flotante
neutron floatingip-associate 7beebe88-10ae-4b8f-ac68-e954515ec239 d531d833-a05a-46d4-864e-1b38063677e7
sleep 1

#Aplicamos las reglas de seguridad al puerto del balanceador
neutron port-update --security-group proyecto4-security-group-lab2 d531d833-a05a-46d4-864e-1b38063677e7
sleep 1