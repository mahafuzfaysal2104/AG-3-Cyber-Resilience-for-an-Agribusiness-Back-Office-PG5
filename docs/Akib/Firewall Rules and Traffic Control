The pfSense firewall is the main network security control of the AG-3 project. We divided the network into five VLANs so that each part of the system can stay separated. Then we created firewall rules to control which VLAN can communicate with another VLAN.

The main idea is simple. We only allow the communication that is required for the project. Any unnecessary communication between VLANs should be blocked and logged.

The firewall processes the rules from top to bottom. For this reason, the required allow rules are placed first. After that, unnecessary internal communication is blocked. Finally, a default block rule is used for any traffic that does not match an approved rule.

### Main Firewall Policy

| Source | Destination | Port / Service | Action | Reason |
|---|---|---|---|---|
| OFFICE VLAN | APP01 | TCP 443 HTTPS | Allow | Office users need to access the Nextcloud business portal. |
| OFFICE VLAN | MON01 | TCP 1514/1515 | Allow | Wazuh agents need to send monitoring information. |
| OFFICE VLAN | BKP01 | Any | Block and Log | Normal office users should not have direct access to the backup system. |
| OFFICE VLAN | MANAGEMENT VLAN | Any | Block and Log | Normal users should not access administrative systems. |
| OFFICE VLAN | Internet | TCP 80/443 | Allow | Required for normal web access and software updates. |
| OFFICE VLAN | Internet | UDP 123 | Allow | Required for time synchronisation. |
| APP01 | BKP01 | TCP 9000 | Allow | Restic needs to send encrypted backups to MinIO. |
| APP01 | MON01 | TCP 1514/1515 | Allow | APP01 needs to send Wazuh security events. |
| APP01 | Internet | TCP 80/443 | Allow | Required for updates and approved Internet access. |
| SECURITY VLAN | Internet | TCP 80/443 | Allow | MON01 requires access for updates. |
| BACKUP VLAN | Internet | TCP 80/443 | Allow | BKP01 may require approved software updates. |
| ADMIN-PC | pfSense | TCP 443 | Allow | Administrator needs secure access to the pfSense web interface. |
| ADMIN-PC | APP01 | TCP 22/443 | Allow | Administrator needs SSH and HTTPS access to APP01. |
| ADMIN-PC | MON01 | TCP 22/443 | Allow | Administrator needs access to the Wazuh server and dashboard. |
| ADMIN-PC | BKP01 | TCP 22/9000/9001 | Allow | Administrator needs to manage the backup server and MinIO. |
| All VLANs | Unapproved internal destination | Any | Block and Log | This provides default network isolation. |
