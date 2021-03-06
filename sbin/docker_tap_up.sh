#!/bin/bash

set -o nounset
set -o errexit

# Local and host tap interfaces
localTapInterface=tap1
hostTapInterface=eth1

# Local and host gateway addresses
localGateway='10.0.75.1/30'
hostGateway='10.0.75.2'
hostNetmask='255.255.255.252'

# Startup local and host tuntap interfaces
sudo ifconfig $localTapInterface $localGateway up
docker run --rm --privileged --net=host --pid=host alpine ifconfig $hostTapInterface $hostGateway netmask $hostNetmask up

sudo route delete -net 10.96.0.0 -netmask 255.240.0.0 10.0.75.2 >/dev/null
sudo route delete -net 10.96.0.0 -netmask 255.240.0.0 10.0.75.2 >/dev/null
sudo route delete -net 10.96.0.0 -netmask 255.240.0.0 10.0.75.2 >/dev/null
sudo route delete -net 10.1.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route delete -net 10.1.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route delete -net 10.1.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route delete -net 172.17.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route delete -net 172.17.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route delete -net 172.17.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route add -net 10.96.0.0 -netmask 255.240.0.0 10.0.75.2 >/dev/null
sudo route add -net 10.1.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null
sudo route add -net 172.17.0.0 -netmask 255.255.0.0 10.0.75.2 >/dev/null

