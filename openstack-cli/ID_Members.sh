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