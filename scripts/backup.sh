#!/bin/bash
# AG-3 automated backup — Faysal (12281612)
# Runs restic backup + integrity check, logs the result.

set -uo pipefail

REPO_DIR="/home/faysal-12281612/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5"
LOG_FILE="/home/faysal-12281612/backup-logs/backup.log"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] $2" >> "$LOG_FILE"
}

# Load credentials
set -a
if ! source "$REPO_DIR/config/.env" 2>/dev/null; then
    log "FAIL" "Could not read config file"
    exit 1
fi
set +a

log "INFO" "Backup started"

# Take the backup
if restic backup "$BACKUP_SOURCE" >> "$LOG_FILE" 2>&1; then
    log "OK" "Backup completed"
else
    log "FAIL" "Backup failed (exit $?)"
    exit 1
fi

# Verify repository integrity
if restic check >> "$LOG_FILE" 2>&1; then
    log "OK" "Integrity check passed"
else
    log "FAIL" "Integrity check failed"
    exit 1
fi

log "OK" "Run finished successfully"
exit 0
