# /configs

Sanitised configuration exports only. **Remove all secrets, credentials, passwords, and real public IPs before committing anything here.**

Organise by component:

- `pfsense/` — firewall/VLAN interface exports (Akib)
- `nextcloud/` — user/role/MFA config (Shourab)
- `wazuh/` — monitoring rules, agent config (Tanvi)
- `restic-minio/` — backup repository and schedule config, credentials excluded (Faysal)
