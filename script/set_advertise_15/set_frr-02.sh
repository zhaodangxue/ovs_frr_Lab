# Define container name
container="frr-02"

# Commands to execute sequentially
commands="
vtysh
conf t
interface lo
ip address 2.2.2.2/32
exit
router bgp 2
bgp router-id 2.2.2.2
no bgp ebgp-requires-policy
redistribute connected
neighbor 100.2.1.2 remote-as 3
neighbor 100.2.1.2 advertisement-interval 15
neighbor 100.2.2.2 remote-as 4
neighbor 100.2.2.2 advertisement-interval 15
neighbor 100.2.3.2 remote-as 5
neighbor 100.2.3.2 advertisement-interval 15
neighbor 100.2.4.2 remote-as 6
neighbor 100.2.4.2 advertisement-interval 15
neighbor 100.2.1.2 next-hop-self
neighbor 100.2.2.2 next-hop-self
neighbor 100.2.3.2 next-hop-self
neighbor 100.2.4.2 next-hop-self
exit
exit
write
"

# Execute commands in the container
echo "$commands" | docker exec -i $container vtysh

echo "Configuration commands with advertisement-interval set to 15 executed successfully in container $container."
