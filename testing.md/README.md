# /testing

Acceptance-test plans, results, screenshots, logs, and RTO/RPO measurement records.

Suggested structure:

- `test-plan.md` — full list of acceptance tests, one per requirement, with pass/fail criteria
- `results/` — dated screenshots, logs, and outputs per test run
- `rto-rpo-log.md` — Faysal's timed recovery measurements against the agreed targets (RPO ≤ 4h, RTO priority ≤ 2h, RTO full ≤ 4h)

Every acceptance test should trace back to a requirement (see Requirements Traceability in the Capstone Checklist) — nothing tested should be untraceable to something specified.
