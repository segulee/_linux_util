#! /bin/bash

vboxmanage extpack install --replace #Oracle_VM_VirtualBox_Extension_Pack-4.3.36.vbox-extpack

vboxmanage hostonlyif create
vboxmanage hostonlyif ipconfig vboxnet0 --ip 192.168.56.1

sudo iptables -A FORWARD -o eth0 -i vboxnet0 -s 192.168.56.0/24 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A POSTROUTING -t nat -j MASQUERADE

sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -p
