# HP Envy VMware Workstation Lab Network Configuration

## Adding Default Route to Host Machine

&nbsp;&nbsp;&nbsp; route add default gw 192.168.1.1 wlp4s0f0

| Virtual Machine Name | Host Name | OS Version |
| ---------------------|-----------|------------|
| Server1              | server1.example.com | RHEL 9_4 |
| Client1              | client1.example.com | RHEL 9_4 |
| Server2              | server2.example.com | RHEL 9_4 |
| Client2              | client2.example.com | RHEL 9_4 |

| Networks      | VM LAN Setting | Iface   |
|---------------|----------------|---------|
| 172.16.165.0  | NAT            | vmnet8  |
| 192.168.10.0 | LAN Segment 1  | vmnet1  |
| 192.168.20.0 | LAN Segment 2  | vmnet2  |
