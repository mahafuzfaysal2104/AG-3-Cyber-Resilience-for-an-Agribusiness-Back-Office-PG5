#!/usr/bin/env bash
# backup.sh — scheduled Restic backup to isolated MinIO repository
# Owner: Faysal | Runs every 4 hours via cron/systemd timer

set -euo pipefail

export RESTIC_REPOSITORY="s3:https://bkp01.local:9000/ag3-backups"
export RESTIC_PASSWORD_FILE="/etc/restic/password"
export AWS_ACCESS_KEY_ID_FILE="/etc/restic/access_key"
export AWS_SECRET_ACCESS_KEY_FILE="/etc/restic/secret_key"

LOGFILE="/var/log/restic/backup-$(date +%F_%H%M).log"

restic backup /srv/nextcloud/data --tag scheduled >> "$LOGFILE" 2>&1
STATUS=$?

restic check >> "$LOGFILE" 2>&1

if [ $STATUS -eq 0 ]; then
  echo "backup_success $(date -Iseconds)" >> /var/log/restic/status.log
else
  echo "backup_failure $(date -Iseconds)" >> /var/log/restic/status.log
fi
