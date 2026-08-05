# APP01-02 – Static IP Configuration

## Objective

Configure a static IPv4 address for the APP01 Ubuntu Server to provide a consistent network identity for future services such as Nextcloud, SSH administration, and web hosting.

---

## Environment

| Item | Value |
|------|------|
| Server Name | APP01 |
| Operating System | Ubuntu Server 24.04.4 LTS |
| Platform | VMware Fusion |
| Network Mode | NAT (Share with my Mac) |
| Network Interface | enp2s0 |

---

## Initial Configuration

The server was initially configured to obtain an IP address dynamically using DHCP.

Original Netplan configuration:

```yaml
network:
  version: 2
  ethernets:
    enp2s0:
      dhcp4: true
```

---

## Static Network Configuration

The Netplan configuration was updated to assign a static IPv4 address.

```yaml
network:
  version: 2
  ethernets:
    enp2s0:
      dhcp4: false
      addresses:
        - 172.16.229.150/24
      routes:
        - to: default
          via: 172.16.229.2
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
```

---

## Configuration Steps

1. Backed up the existing Netplan configuration.
2. Modified the Netplan configuration file (`/etc/netplan/50-cloud-init.yaml`).
3. Validated the configuration using:

```bash
sudo netplan try
```

4. Applied the configuration:

```bash
sudo netplan apply
```

5. Verified network connectivity and routing.

---

## Verification Results

### Static IP Address

```bash
ip addr show enp2s0
```

Result:

- IP Address: **172.16.229.150/24**

---

### Default Gateway

```bash
ip route
```

Result:

- Default Gateway: **172.16.229.2**
- Route configured using static configuration.

---

### Internet Connectivity

```bash
ping -c 4 8.8.8.8
```

Result:

- 4 packets transmitted
- 4 packets received
- 0% packet loss

---

### DNS Resolution

```bash
ping -c 4 google.com
```

Result:

Successful responses confirmed that DNS resolution was functioning correctly.

---

## Outcome

The Ubuntu Server was successfully configured with a static IPv4 address using Netplan. Network connectivity, routing, and DNS resolution were verified successfully. The server is now ready for subsequent deployment tasks including system hardening, Apache, PHP, MariaDB, and Nextcloud installation.

---

## Evidence

### Static IP Verification

See:

```
evidence/APP01/02-static-ip-verification.png
```

The evidence demonstrates:

- Static IPv4 address assignment
- Static routing configuration
- Successful Internet connectivity
- Successful DNS resolution

---

## Author

Ashraful Abedin Shourab

COIT20265 – Networks and Information Security Project

Group PG5

2026
