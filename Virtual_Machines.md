# HP Envy VMware Workstation Lab Network Configuration

## Adding Default Route to Host Machine

&nbsp;&nbsp;&nbsp; route add default gw 192.168.1.1 wlp4s0f0

## Virtual Networks

| Networks      | VM LAN Setting | Iface   |
|---------------|----------------|---------|
| 172.16.165.0  | NAT            | vmnet8  |
| 192.168.10.0 | LAN Segment 1  | vmnet1  |
| 192.168.20.0 | LAN Segment 2  | vmnet2  |

## Virtual Machines

| Virtual Machine Name | Host Name | OS Version |
| ---------------------|-----------|------------|
| Golden               | golden.example.com  | RHEL 9_4 |
| Server1              | server1.example.com | RHEL 9_4 |
| Client1              | client1.example.com | RHEL 9_4 |
| Server2              | server2.example.com | RHEL 9_4 |
| Client2              | client2.example.com | RHEL 9_4 |


## Virtual Machine Network Interfaces

|Virtual Machine | ens160 IPv4 | ens160 MAC | VM LAN Setting ens160 | eth1 | eth1 MAC | VM LAN Setting eth1 |
|------------|------------  |------------|------------|------------|------------|------------|
| Golden | 172.16.165.135/24 | 00:0C:29:5F:C9:05 | vmnet8 / NAT  | N/A | N/A | N/A |
| Server1 | 172.16.165.10/24 |   |  |  |  |  |
| Client1 | 172.16.165.11/24 |  |  |  |  |  |
| Server2 | 172.16.165.20/24 |  |  |  |  |  |
| Client2 | 172.16.165.21/24 |  |  |  |  |  |
