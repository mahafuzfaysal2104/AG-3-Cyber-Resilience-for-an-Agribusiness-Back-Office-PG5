# AG-3 Cyber Resilience — Backup, Ransomware Simulation and Recovery Scripts

## Overview

This document records the **actual shell scripts shared from APP01** for the AG-3 Cyber Resilience prototype at Plains Pastoral Co. The scripts support automated Nextcloud backup, a controlled ransomware-impact simulation, and file-level recovery from Restic snapshots stored in MinIO.

| Component | Configuration |
|---|---|
| Application server | APP01 (Ubuntu Server) |
| Application | Nextcloud |
| Backup platform | Restic with MinIO on BKP01 |
| Backup environment | `/etc/restic-nextcloud.env` |
| Demonstration folder | `/var/ncdata/manager/files/Ransomeware-Demo` |
| Backup log | `/var/log/nextcloud-backup.log` |

> **Source note:** The code blocks below reproduce the script content provided from APP01, with terminal/Markdown escaping normalised for readability. The scripts have not been modified to address their operational limitations. Do not publish credentials from `/etc/restic-nextcloud.env`.

## 1. Automated Nextcloud backup

**Installed script:** `/usr/local/sbin/nextcloud-backup.sh`

This script enables Nextcloud maintenance mode, dumps the `nextcloud` MariaDB database, backs up the Nextcloud data, application directory and database dump using Restic, writes results to a log, and disables maintenance mode.

```bash
#!/bin/bash

set -u

LOG_FILE="/var/log/nextcloud-backup.log"
ENV_FILE="/etc/restic-nextcloud.env"
RESTIC="/usr/local/bin/restic"

timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

echo "$(timestamp) BACKUP_STARTED" >> "$LOG_FILE"

set -a
source "$ENV_FILE"
set +a

# Turn on Nextcloud maintenance mode
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on >> "$LOG_FILE" 2>&1

# Create fresh MariaDB dump
mkdir -p /opt/nextcloud-backup

if ! mysqldump nextcloud > /opt/nextcloud-backup/nextcloud-db.sql 2>> "$LOG_FILE"; then
    echo "$(timestamp) BACKUP_FAILED Database dump failed" >> "$LOG_FILE"
    sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off >> "$LOG_FILE" 2>&1
    exit 1
fi

# Run Restic backup
if timeout 10m "$RESTIC" -o s3.connections=1 backup \
    /var/ncdata \
    /var/www/nextcloud \
    /opt/nextcloud-backup \
    --host app01 \
    --tag app01 \
    --tag nextcloud-full \
    --tag automated >> "$LOG_FILE" 2>&1
then
    echo "$(timestamp) BACKUP_SUCCESS" >> "$LOG_FILE"
    EXIT_CODE=0
else
    echo "$(timestamp) BACKUP_FAILED Restic backup failed" >> "$LOG_FILE"
    EXIT_CODE=1
fi

# Turn maintenance mode off
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off >> "$LOG_FILE" 2>&1

exit $EXIT_CODE
```

**Run manually:**

```bash
sudo /usr/local/sbin/nextcloud-backup.sh
sudo tail -n 30 /var/log/nextcloud-backup.log
```

**Backup coverage:** `/var/ncdata`, `/var/www/nextcloud`, and `/opt/nextcloud-backup` (including the MariaDB dump). Restic tags: `app01`, `nextcloud-full`, `automated`.

## 2. Controlled ransomware-impact simulation

**Installed script:** `/usr/local/sbin/ag3-ransomware-demo`

This script checks the demonstration directory, refuses to run if `.locked` files are already present, renames regular files at the top level of the folder, creates a simulated ransom note, and refreshes Nextcloud's file index. It **does not encrypt files or run malware**.

```bash
#!/bin/bash
set -e

TARGET="/var/ncdata/manager/files/Ransomeware-Demo"
OCC="/var/www/nextcloud/occ"

echo "=========================================="
echo " AG-3 SAFE RANSOMWARE IMPACT SIMULATION"
echo "=========================================="
echo
echo "[1] Target: $TARGET"

if [ ! -d "$TARGET" ]; then
    echo "ERROR: Test directory does not exist."
    exit 1
fi

if find "$TARGET" -maxdepth 1 -type f -name "*.locked" | grep -q .; then
    echo "ERROR: Folder already appears to be in simulated ransomware state."
    exit 1
fi

echo "[2] Simulating file impact..."

for f in "$TARGET"/*; do
    if [ -f "$f" ]; then
        mv -- "$f" "$f.locked"
    fi
done

echo "[3] Creating simulated ransom note..."

echo "AG-3 SAFE RANSOMWARE SIMULATION
The test files have been made unavailable.
Recovery from the protected backup is required." \
> "$TARGET/README_RECOVERY_TEST.txt"

chown www-data:www-data "$TARGET/README_RECOVERY_TEST.txt"

echo "[4] Updating Nextcloud index..."

sudo -u www-data php "$OCC" files:scan \
  --path="manager/files/Ransomeware-Demo"

echo
echo "=========================================="
echo " SIMULATION COMPLETED"
echo " Refresh Nextcloud to view the impact."
echo "=========================================="
```

**Run:**

```bash
sudo /usr/local/sbin/ag3-ransomware-demo
```

**Expected result:** Example files such as `report.pdf` are renamed to `report.pdf.locked`, and `README_RECOVERY_TEST.txt` is created. Refresh Nextcloud to view the simulated impact.

## 3. Recover the demonstration folder

**Installed script:** `/usr/local/sbin/ag3-restore-demo`

This script loads the Restic repository settings, restores the selected snapshot to `/tmp/ag3-restore`, copies the recovered demonstration folder back into Nextcloud, rescans the files, and restarts the Wazuh agent.

```bash
#!/bin/bash
set -e

SNAPSHOT="$1"

TARGET="/var/ncdata/manager/files/Ransomeware-Demo"
RESTORED="/tmp/ag3-restore/var/ncdata/manager/files/Ransomeware-Demo"
OCC="/var/www/nextcloud/occ"

if [ -z "$SNAPSHOT" ]; then
    echo "Usage: sudo ag3-restore-demo SNAPSHOT_ID"
    exit 1
fi

echo "=========================================="
echo " AG-3 RANSOMWARE RECOVERY"
echo "=========================================="
echo
echo "[1] Recovery snapshot: $SNAPSHOT"
echo "[2] Preparing temporary recovery area..."

rm -rf /tmp/ag3-restore
mkdir -p /tmp/ag3-restore

echo "[3] Connecting to BKP01 / MinIO..."

set -a
source /etc/restic-nextcloud.env
set +a

echo "[4] Restoring protected files..."

restic -o s3.connections=1 restore "$SNAPSHOT" \
  --target /tmp/ag3-restore \
  --include "$TARGET"

if [ ! -d "$RESTORED" ]; then
    echo "ERROR: Restored test directory was not found."
    exit 1
fi

echo "[5] Replacing affected test folder..."

rm -rf "$TARGET"
cp -a "$RESTORED" "/var/ncdata/manager/files/"

echo "[6] Updating Nextcloud index..."

sudo -u www-data php "$OCC" files:scan \
  --path="manager/files/Ransomeware-Demo"

echo "[7] Refreshing Wazuh realtime monitoring..."
systemctl restart wazuh-agent
sleep 3
echo
echo "=========================================="
echo " RECOVERY COMPLETED SUCCESSFULLY"
echo " Refresh Nextcloud and verify the files."
echo "=========================================="
```

**Find a snapshot:**

```bash
sudo bash -c 'set -a; source /etc/restic-nextcloud.env; set +a; restic -o s3.connections=1 snapshots'
```

**Run recovery:**

```bash
sudo /usr/local/sbin/ag3-restore-demo SNAPSHOT_ID
```

Replace `SNAPSHOT_ID` with the ID of a **verified clean snapshot created before the simulation**. Refresh Nextcloud and verify the restored files.

## 4. Demonstration sequence

| Step | Action | Expected outcome |
|---|---|---|
| 1 | Prepare disposable test files in Nextcloud | Clean files are accessible |
| 2 | Run the Nextcloud backup script | A Restic snapshot is stored in MinIO |
| 3 | Identify and record the clean snapshot ID | Recovery point is known |
| 4 | Run `ag3-ransomware-demo` | Files receive `.locked` extensions and a note appears |
| 5 | Review Nextcloud and available Wazuh events | Simulated impact can be observed; alerts depend on monitoring configuration |
| 6 | Run `ag3-restore-demo SNAPSHOT_ID` | The test folder is recovered from the snapshot |
| 7 | Verify the files through Nextcloud | Clean contents are accessible again |

## 5. Operational limitations and safety notes

These scripts reflect the implementation shared from APP01; they are **not production-hardened recovery tools**.

- The recovery script runs `rm -rf "$TARGET"` before copying the restored folder. This permanently removes the affected demonstration folder and does not preserve forensic evidence. Use only with disposable test data and a verified recovery point.
- The recovery script also removes `/tmp/ag3-restore` at startup. Do not use that temporary location for unrelated data.
- The restore script expects a snapshot argument; running it without one may exit before showing the intended usage message because of `SNAPSHOT="$1"` under `set -e` (without `set -u`, the variable expands to empty, so the usage check still works).
- The simulation only renames top-level regular files; it does not encrypt files, affect nested files, or represent a real malware infection.
- The backup script's maintenance-mode cleanup is handled for its explicit database-dump and Restic outcomes, but not every possible interruption or early failure.
- Wazuh agent restart does not itself prove that an alert was generated. Detection depends on configured monitoring and rules.
- The demonstrated restore is **file-level recovery**, not a complete Nextcloud application, database, or disaster-recovery restoration.
- The repository credentials and passwords stored in `/etc/restic-nextcloud.env` must remain private and must **not** be committed to GitHub.

## 6. Suggested GitHub folder layout

```text
scripts/
├── README.md
├── nextcloud-backup.sh
├── ag3-ransomware-demo
└── ag3-restore-demo
```

The three code blocks above can also be saved as their respective standalone shell files. The installed filenames intentionally omit `.sh` for the two demonstration scripts.

## Conclusion

The AG-3 prototype demonstrates how encrypted Restic backups stored in MinIO can support recovery from a controlled file-impact scenario on Nextcloud. The simulation shows visible file disruption, and the recovery script restores a selected clean snapshot. This is evidence of a limited, controlled recovery workflow, not a claim of complete ransomware protection or full-site disaster recovery.
