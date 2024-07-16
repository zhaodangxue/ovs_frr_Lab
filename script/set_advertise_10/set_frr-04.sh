# Define container name
container="frr-04"

# Commands to execute sequentially
commands="
vtysh
conf t
interface lo
ip address 4.4.4.4/32
exit
router bgp 4
bgp router-id 4.4.4.4
no bgp ebgp-requires-policy
redistribute connected
neighbor 100.1.2.1 remote-as 1
neighbor 100.1.2.1 advertisement-interval 10
neighbor 100.2.2.1 remote-as 2
neighbor 100.2.2.1 advertisement-interval 10
neighbor 100.1.2.1 next-hop-self
neighbor 100.2.2.1 next-hop-self
exit
exit
write
"

# Execute commands in the container
echo "$commands" | docker exec -i $container vtysh

echo "Configuration commands with advertisement-interval set to 10 executed successfully in container $container."
