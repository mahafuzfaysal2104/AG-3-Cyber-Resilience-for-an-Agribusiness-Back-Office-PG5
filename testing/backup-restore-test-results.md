# Backup and Restore — Test Results _ FAYSAL

## Test 1 — Backup
- Action: Backed up ~/ag3-testdata (3 synthetic files) with `restic backup`
- Result: Snapshot saved successfully
- Verification: `restic snapshots` listed the snapshot; `restic check` reported no errors;
  `restic ls latest` confirmed the correct files
- Status: PASS

## Test 2 — Restore
- Action: Deleted the originals (`rm -rf ~/ag3-testdata`) to simulate data loss, then restored
  with `restic restore latest --target ~/ag3-restored`
- Result: Restored 6 files/dirs (142 B) successfully
- Verification: All three files (invoice001.txt, livestock.txt, suppliers.txt) recovered with
  contents matching the originals
- Status: PASS
- Note: Restic preserves the original absolute path, so the files were restored to
  `~/ag3-restored/home/faysal-12281612/ag3-testdata`. An initially assumed `/root/` path was
  incorrect and had to be located manually using `ls -R`.

## Test 3 — Credential isolation (Week 6)
- Action: Create a restricted office-user account and confirm it cannot list or read the
  backup bucket via either `mc` or Restic
- Status: Not started — deferred to Week 6 (MinIO Community Edition requires the `mc` client)
- Note: An "Access Denied" error in this test is a PASS, not a failure

## Test 4 — Network isolation (Week 6, dependent)
- Action: Connectivity test from an office-VLAN machine to MinIO (expect failure), and from
  the application server (expect success)
- Status: Blocked — depends on Akib's VLAN and firewall configuration (card #37)


## Notes
- These tests validate the core backup/recovery capability of the MVP.
- restic check directly addresses the risk of "backups that complete but fail to restore."
- Future tests: deliberate backup-failure test, timed recovery with RTO/RPO measurement,
  file-count and SHA-256 comparison.
