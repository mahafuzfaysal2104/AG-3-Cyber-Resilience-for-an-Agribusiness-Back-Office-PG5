#!/bin/bash
# AG-3 automated backup — Faysal (12281612)
# Runs restic backup + check, writes one JSON event per attempt for Wazuh.

set -uo pipefail

REPO_DIR="/home/faysal-12281612/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5"
JSON_LOG="/var/log/cyber-resilience/backup.json"
TEXT_LOG="/home/faysal-12281612/backup-logs/backup.log"
JOB_NAME="ag3-backup"
START=$(date +%s)

emit() {
    local status="$1" message="$2"
    local duration=$(( $(date +%s) - START ))
    printf '{"timestamp":"%s","event_type":"backup","status":"%s","job_name":"%s","hostname":"%s","source":"%s","destination":"%s","duration_seconds":%d,"message":"%s"}\n' \
        "$(date -Is)" "$status" "$JOB_NAME" "$(hostname)" \
        "${BACKUP_SOURCE:-unknown}" "${RESTIC_REPOSITORY:-unknown}" \
        "$duration" "$message" >> "$JSON_LOG"
}

set -a
if ! source "$REPO_DIR/config/.env" 2>/dev/null; then
    emit "failure" "Could not read config file"
    exit 1
fi
set +a

if ! restic backup "$BACKUP_SOURCE" >> "$TEXT_LOG" 2>&1; then
    emit "failure" "Backup failed - see $TEXT_LOG"
    exit 1
fi

if ! restic check >> "$TEXT_LOG" 2>&1; then
    emit "failure" "Integrity check failed - see $TEXT_LOG"
    exit 1
fi

emit "success" "Backup completed and integrity check passed"
exit 0
