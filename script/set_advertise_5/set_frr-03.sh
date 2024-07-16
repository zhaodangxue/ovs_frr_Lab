# Define container name
container="frr-03"

# Commands to execute sequentially
commands="
vtysh
conf t
interface lo
ip address 3.3.3.3/32
exit
router bgp 3
bgp router-id 3.3.3.3
no bgp ebgp-requires-policy
redistribute connected
neighbor 100.1.1.1 remote-as 1
neighbor 100.1.1.1 advertisement-interval 5
neighbor 100.2.1.1 remote-as 2
neighbor 100.2.1.1 advertisement-interval 5
neighbor 100.1.1.1 next-hop-self
neighbor 100.2.1.1 next-hop-self
exit
exit
write
"

# Execute commands in the container
echo "$commands" | docker exec -i $container vtysh

echo "Configuration commands executed successfully in container $container."
