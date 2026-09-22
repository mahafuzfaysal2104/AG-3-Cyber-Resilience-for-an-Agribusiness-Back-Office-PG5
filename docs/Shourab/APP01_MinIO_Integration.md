# AG-3 APP01 and MinIO Integration

## Overview

This document summarises the integration work completed between **APP01 (Nextcloud)** and **BKP01 (MinIO backup server)** with Foysal.

- APP01 / Nextcloud: `10.20.20.10`
- BKP01 / MinIO: `10.20.40.10`
- Backup tool: Restic
- MinIO API port: `9000`
- Backup direction: `APP01 -> pfSense -> BKP01`

---

## What I Did

I worked with Foysal to connect the Nextcloud server to the MinIO backup server and test a real backup and recovery process.

The work included:

- Testing network connectivity between APP01 and BKP01
- Confirming the MinIO API was reachable
- Configuring Restic on APP01
- Connecting Restic to the MinIO bucket
- Creating a MariaDB database dump
- Backing up Nextcloud user data
- Backing up the Nextcloud application and database dump
- Verifying the created snapshots
- Restoring a database backup file from MinIO back to APP01

---

## Network Connectivity Test

From APP01, MinIO connectivity was tested using:

```bash
curl -v http://10.20.40.10:9000
```

MinIO returned:

```text
403 Forbidden
```

This was expected because the request did not include authentication. It confirmed that APP01 could successfully reach the MinIO API.

---

## Problems and Solutions

### 1. Time Synchronisation Problem

Restic initially failed because the time difference between APP01 and BKP01 was too large.

**Solution:**  
The system time on BKP01 was corrected before retrying the Restic repository connection.

---

### 2. Restic Communication Was Hanging

Restic could open the repository but became stuck when reading or writing data across the network.

The APP01 interface was using MTU `1500`.

**Solution:**

```bash
sudo ip link set dev enp26s0 mtu 1400
```

After changing the MTU to `1400`, Restic communication worked correctly.

This also matched an earlier issue where HTTPS traffic through pfSense only worked correctly after reducing the MTU.

---

### 3. Restic Cache Permission Problem

Some previous Restic commands had created root-owned cache files.

**Solution:**

```bash
sudo chown -R shourab:shourab /home/shourab/.cache/restic
```

After correcting the ownership, Restic worked normally as the APP01 user.

---

## Backup Process

### Step 1 - Connect Restic to MinIO

The Restic repository was configured to use the MinIO bucket:

```bash
export RESTIC_REPOSITORY="s3:http://10.20.40.10:9000/ag3-plains-pastoral-backups"
export AWS_ACCESS_KEY_ID="backup-administrator"
export AWS_SECRET_ACCESS_KEY="<REDACTED>"
export RESTIC_PASSWORD="<REDACTED>"
```

> Passwords and secret keys are intentionally not included in GitHub.

---

### Step 2 - Verify Repository Access

```bash
/tmp/restic_0.19.1_linux_arm64 -o s3.connections=1 snapshots
```

After the MTU and cache fixes, the repository snapshot list was successfully displayed from APP01.

---

### Step 3 - Create Nextcloud Database Backup

A MariaDB dump was created at:

```text
/opt/nextcloud-backup/nextcloud-db.sql
```

This file is required because Nextcloud depends on both the stored files and the database.

---

### Step 4 - Back Up Nextcloud Data

```bash
sudo -E /tmp/restic_0.19.1_linux_arm64   -o s3.connections=1   backup /var/ncdata   --host app01   --tag app01   --tag nextcloud-data   --tag production   --tag Ashraful_21-09-2026
```

Successful snapshot:

```text
13b84d39
```

Approximate data:

```text
400.742 MiB
```

---

### Step 5 - Back Up Application and Database

```bash
sudo -E /tmp/restic_0.19.1_linux_arm64   -o s3.connections=1   backup /var/www/nextcloud /opt/nextcloud-backup   --host app01   --tag app01   --tag nextcloud-system   --tag production   --tag Ashraful_21-09-2026
```

Successful snapshot:

```text
ae4a98fe
```

Approximate data:

```text
806.073 MiB
```

---

## Recovery Test

A controlled restore was performed using snapshot:

```text
ae4a98fe
```

The MariaDB dump was restored into a separate test directory:

```bash
mkdir -p ~/restic-restore-test
```

```bash
/tmp/restic_0.19.1_linux_arm64   -o s3.connections=1   restore ae4a98fe   --target ~/restic-restore-test   --include /opt/nextcloud-backup/nextcloud-db.sql
```

The restored file was verified at:

```text
/home/shourab/restic-restore-test/opt/nextcloud-backup/nextcloud-db.sql
```

The file size was approximately `3.1 MB`.

---

## Result

The integration proved that:

```text
APP01 / Nextcloud
        |
        | Restic Backup
        v
      pfSense
        |
        v
BKP01 / MinIO
        |
        | Restore when required
        v
      APP01
```

The backup and recovery process was successfully tested using real Nextcloud data.

---

## Why This Is Important

This supports the AG-3 cyber-resilience objective because the backup is stored on a separate system and network segment.

If APP01 is affected by ransomware, corruption, accidental deletion or system failure, the stored Restic snapshots can be used to recover the Nextcloud data and system.

