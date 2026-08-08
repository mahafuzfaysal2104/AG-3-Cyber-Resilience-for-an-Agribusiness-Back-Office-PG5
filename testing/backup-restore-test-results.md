# Backup and Restore — Test Results _ FAYSAL

## Test 1 — Backup
- Action: Backed up ~/ag3-testdata (3 synthetic files) with `restic backup`
- Result: Snapshot saved successfully
- Verification: `restic snapshots` listed the snapshot; `restic check` reported no errors;
  `restic ls latest` confirmed the correct files
- Status: PASS

## Test 2 — Restore


## Notes
- These tests validate the core backup/recovery capability of the MVP.
- restic check directly addresses the risk of "backups that complete but fail to restore."
- Future tests: deliberate backup-failure test, timed recovery with RTO/RPO measurement,
  file-count and SHA-256 comparison.
