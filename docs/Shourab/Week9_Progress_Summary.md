# AG-3 Weekly Progress Summary

## Week Summary

This week I focused mainly on integrating **APP01 (Nextcloud)** with the other major AG-3 components.

My main integration work was completed with:

- **Foysal** - MinIO backup and recovery
- **Tanvi** - Wazuh security monitoring

The work moved APP01 from an individual standalone build toward an integrated cyber-resilience environment.

---

## 1. APP01 and MinIO Integration

I worked with Foysal to connect APP01 to the MinIO backup server.

### Completed Work

- Confirmed connectivity from APP01 to MinIO on TCP port `9000`
- Connected Restic on APP01 to the MinIO backup bucket
- Investigated Restic communication problems
- Identified an MTU issue on APP01
- Reduced `enp26s0` MTU from `1500` to `1400`
- Corrected Restic cache ownership
- Successfully accessed the remote Restic repository
- Backed up `/var/ncdata`
- Backed up `/var/www/nextcloud`
- Created and backed up the Nextcloud MariaDB dump
- Verified successful snapshots
- Performed a controlled restore of the database dump from MinIO back to APP01

### Successful Backup Snapshots

```text
13b84d39 - Nextcloud data
ae4a98fe - Nextcloud application and database backup
```

This proved that real Nextcloud data can be backed up to BKP01 and recovered when required.

---

## 2. APP01 and Wazuh Integration

I worked with Tanvi to connect APP01 to the Wazuh Manager.

### Completed Work

- Confirmed APP01 could reach Wazuh Manager `10.20.30.10`
- Confirmed TCP ports `1514` and `1515`
- Checked the installed Wazuh agent
- Corrected the placeholder `MANAGER_IP` setting
- Connected the agent to the Wazuh Manager
- Confirmed APP01 was registered and visible to Tanvi
- Tested File Integrity Monitoring
- Identified that the default FIM scan was not real-time
- Created a real-time monitored test directory
- Successfully generated and viewed a Wazuh FIM event
- Identified Nextcloud Company Shared as Group Folder ID `4`
- Added `/var/ncdata/__groupfolders/4/files` to Wazuh real-time monitoring
- Created and modified a file through Nextcloud
- Confirmed the real Nextcloud file event appeared in Tanvi's Wazuh Dashboard

---

## 3. Integration Result

The current APP01 integration now works like this:

```text
                         +----------------------+
                         |      Wazuh Manager   |
                         |      10.20.30.10     |
                         +----------^-----------+
                                    |
                              Security Events
                                    |
+-------------------+         +-----+------+
|   Nextcloud APP01 |-------->|  pfSense   |
|   10.20.20.10     |         +-----+------+
+---------+---------+               |
          |                         |
          | Restic Backup           |
          v                         |
+-------------------+               |
|   MinIO BKP01     |<--------------+
|   10.20.40.10     |
+-------------------+
```

APP01 is now able to:

- provide Nextcloud file services
- send security monitoring events to Wazuh
- send backup data to MinIO
- restore backed-up data from MinIO

---

## 4. Problems Solved This Week

### MTU Problem

Restic communication through pfSense was hanging even though basic TCP connectivity worked.

**Solution:**  
Changed APP01 interface MTU from `1500` to `1400`.

---

### Restic Cache Permission Problem

Root-owned Restic cache files prevented normal repository access.

**Solution:**

```bash
sudo chown -R shourab:shourab /home/shourab/.cache/restic
```

---

### Wazuh Agent Configuration Problem

The Wazuh agent configuration still contained:

```text
MANAGER_IP
```

**Solution:**  
Changed it to:

```text
10.20.30.10
```

and restarted the agent.

---

### Wazuh FIM Event Delay

The original Wazuh FIM configuration used a 12-hour scan interval and was not configured for immediate real-time monitoring.

**Solution:**  
Configured selected directories with:

```xml
realtime="yes"
```

This allowed file changes to appear immediately in the Wazuh Dashboard.

---

## 5. Current Achievement

At the end of this week, APP01 is no longer operating as an isolated Nextcloud server.

It is now integrated with:

- pfSense for network segmentation and routing
- MinIO for backup and recovery
- Wazuh for security monitoring

This is an important step toward the AG-3 objective of demonstrating a practical cyber-resilience solution for Plains Pastoral Co.

---

## 6. Next Steps

- Make the APP01 MTU `1400` configuration persistent
- Secure Restic credentials instead of using temporary environment variables
- Automate the Nextcloud database dump
- Automate Restic backups using a systemd timer
- Define backup retention rules
- Perform a larger/full recovery test
- Continue testing Wazuh monitoring on important Nextcloud folders
- Document screenshots and GitHub evidence for the final project report

