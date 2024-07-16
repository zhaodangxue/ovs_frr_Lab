#!/bin/bash
#create br br0
ovs-vsctl add-br br0
#verify br0 created
ovs-vsctl show