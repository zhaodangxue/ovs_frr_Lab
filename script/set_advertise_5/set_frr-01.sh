#!/bin/bash
# Define container name
container="frr-01"

# Here are the commands to execute sequentially
commands="
vtysh
conf t
interface lo
ip address 1.1.1.1/32
exit
router bgp 1
bgp router-id 1.1.1.1
no bgp ebgp-requires-policy
redistribute connected
neighbor 100.1.1.2 remote-as 3
neighbor 100.1.1.2 advertisement-interval 5
neighbor 100.1.2.2 remote-as 4
neighbor 100.1.2.2 advertisement-interval 5
neighbor 100.1.3.2 remote-as 5
neighbor 100.1.3.2 advertisement-interval 5
neighbor 100.1.4.2 remote-as 6
neighbor 100.1.4.2 advertisement-interval 5
neighbor 100.1.1.2 next-hop-self
neighbor 100.1.2.2 next-hop-self
neighbor 100.1.3.2 next-hop-self
neighbor 100.1.4.2 next-hop-self
exit
exit
write
"

# Execute commands in the container
echo "$commands" | docker exec -i $container vtysh

echo "Configuration commands executed successfully in container $container."
