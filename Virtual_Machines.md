# HP Envy VMware Workstation Lab Network Configuration

## Adding Default Route to Host Machine

`route add default gw 192.168.1.1 wlp4s0f0`

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
| Utility              | utility.example.com | RHEL 9_4 |
| Server1              | server1.example.com | RHEL 9_4 |
| Client1              | client1.example.com | RHEL 9_4 |
| Server2              | server2.example.com | RHEL 9_4 |
| Client2              | client2.example.com | RHEL 9_4 |

## Virtual Machine Network Interfaces

|Virtual Machine | ens160 IPv4 | ens160 MAC | VM LAN Setting ens160 | ens224 IPv4 | ens224 MAC | VM LAN Setting ens224 |
|------------|------------  |------------|:------------:|------------|------------|:------------:|
| Golden | 172.16.165.135/24 | 00:0C:29:5f:c9:05 | vmnet8 / NAT | N/A | N/A | N/A |
| Utility | 172.16.165.5/24 | 00:0c:29:9F:0f:ce | vmnet8 / NAT | N/A | N/A | N/A |
| Server1 | 172.16.165.10/24 | 00:0c:29:5b:89:74 | vmnet8 / NAT | 192.168.10.10 | 00:0c:29:5b:89:7e | LAN Segment 1 |
| Client1 | 192.168.10.20/24 | 00:0c:29:9c:e3:67 | LAN Segment 1 | N/A | N/A | N/A |
| Server2 | 172.16.165.10/24 | 00:0c:29:6e:05:c1 | vmnet8 / NAT | 192.168.20.10 | 00:0c:29:6e:05:cb | LAN Segment 2 |
| Client2 | 192.168.20.20/24 | 00:0c:29:d6:ed:97 | LAN Segment 2 | N/A | N/A | N/A |

<br>

## Lab VM Manual Network Configuration Steps

### Utility

```bash
hostnamectl set-hostname utility.example.com
nmcli con mod ens160 \
   ipv4.address 172.16.165.5/24 \
   ipv4.gateway 172.16.165.2 \
   ipv4.dns 172.16.165.2 \
   ipv4.method manual
nmcli con reload
nmcli con down ens160
nmcli con up ens160
```

### Client1

```bash
hostnamectl set-hostname client1.example.com
nmcli con mod ens160 \
   ipv4.address 192.168.10.20/24 \
   ipv4.gateway 192.168.10.1 \
   ipv4.dns 192.168.10.1 \
   ipv4.method manual
nmcli con reload
nmcli con down ens160
nmcli con up ens160
```

### Client2

```bash
hostnamectl set-hostname client1.example.com
nmcli con mod ens160 \
   ipv4.address 192.168.20.20/24 \
   ipv4.gateway 192.168.20.1 \
   ipv4.dns 192.168.20.1 \
   ipv4.method manual
nmcli con reload
nmcli con down ens160
nmcli con up ens160
```

### Server1

```bash
hostnamectl set-hostname server1.example.com
nmcli con mod ens160 \
   ipv4.address 172.16.165.10/24 \
   ipv4.gateway 172.16.165.2 \
   ipv4.dns 172.16.165.2 \
   ipv4.method manual 
nmcli con reload
nmcli con down "ens160"
nmcli con up "ens160"

nmcli con add con-name ens224 \
   type ethernet \
   ifname ens224 \ 
   ipv4.address 192.168.10.10/24 \
   ipv4.gateway 192.168.10.1 \
   ipv4.method manual
```

### Server2

```bash
hostnamectl set-hostname server2.example.com
nmcli con mod ens160 \
   ipv4.address 172.16.165.20/24 \
   ipv4.gateway 172.16.165.2 \
   ipv4.dns 172.16.165.2 \
   ipv4.method manual 
nmcli con reload
nmcli con down "ens160"
nmcli con up "ens160"

nmcli con add con-name "ens224" \
   type ethernet \
   ifname ens224 \ 
   ipv4.address '192.168.20.10/24' \
   ipv4.gateway 192.168.20.1 \
   ipv4.method manual
