# Backup Retention Policy — AG-3

**Owner:** Faysal (12281612)
**Applied:** 2026-08-31

## Policy

restic forget --keep-hourly 6 --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune

| Rule | Keeps | Reason |
|---|---|---|
| keep-hourly 6 | 6 most recent | One full day at the 4-hourly schedule |
| keep-daily 7 | 1 per day, 7 days | Recover any day in the past week |
| keep-weekly 4 | 1 per week, 4 weeks | Covers a month |
| keep-monthly 6 | 1 per month, 6 months | Long-term reference points |

## Why

The scheduled backup runs 6 times a day (~2,200 snapshots/year). Most are
near-identical. Retention keeps a useful spread across time while stopping
the repository growing without limit.

## Result of first run

- Before: 6 snapshots
- After: 3 snapshots (513 B reclaimed, 0 B unused space remaining)
- `restic check` passed with no errors after pruning

## Safety note

`forget --prune` permanently deletes backup data. Always run with `--dry-run`
first and read which snapshots would be removed before running for real.
