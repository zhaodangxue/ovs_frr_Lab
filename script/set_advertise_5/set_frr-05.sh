# Define container name
container="frr-05"

# Commands to execute sequentially
commands="
vtysh
conf t
interface lo
ip address 5.5.5.5/32
exit
router bgp 5
bgp router-id 5.5.5.5
no bgp ebgp-requires-policy
redistribute connected
neighbor 100.1.3.1 remote-as 1
neighbor 100.1.3.1 advertisement-interval 5
neighbor 100.2.3.1 remote-as 2
neighbor 100.2.3.1 advertisement-interval 5
neighbor 100.1.3.1 next-hop-self
neighbor 100.2.3.1 next-hop-self
exit
exit
write
"

# Execute commands in the container
echo "$commands" | docker exec -i $container vtysh

echo "Configuration commands executed successfully in container $container."
