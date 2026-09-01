# Week 7 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, automation, and recovery
**Week 7 goal:** Move from manual backups to automated ones — build the config file, write a backup script, schedule it every 4 hours, prove it fails loudly, apply a retention policy, and begin sending backup status to Tanvi's Wazuh instance. This week delivers **OBJ-05 (automated encrypted backup by Week 9)** ahead of schedule.

## Planned tasks (Kanban board)

| # | Card | Depends on |
|---|---|---|
| #45 | Create environment config file | Done |
| #53 | Write automated backup script (backup.sh) | Done |
| #54 | Schedule backup every 4 hours | #53 |
| #55 | Test deliberate backup failure | #54 |
| #56 | Apply retention policy (restic forget/prune) | #53 |
| #57 | Send backup status to Wazuh with Tanvi | #53, Tanvi #33 |
| #58 | Refine #43 with scoped policy | — |
| #44 | Coordinate network isolation test with Akib | **Blocked** — Akib's VLAN/firewall |

**Carried in from Week 6:** #45 (config file) and #46 (scheduling research, in review) moved across. #44 remains blocked on an external dependency.

<img width="1918" height="1043" alt="image" src="https://github.com/user-attachments/assets/7fe18b48-5acc-4aeb-8ae3-bd1805c9bbf4" />
<img width="1919" height="1043" alt="image" src="https://github.com/user-attachments/assets/17fe1bca-c5c0-488a-b507-986746bc04f4" />


---

## Week 7 task list

- [X] **Create environment config file (#45)**

- What I plan to do: Create `config/.env` holding the MinIO and Restic credentials, endpoint and repository path, plus a committed `config/.env.example` containing placeholders only. Add `config/.env` to `.gitignore`, set `chmod 600`, and load it with `set -a; source config/.env; set +a`.

- Why this matters: Four separate command failures across Weeks 5 and 6 were caused by retyping environment variables by hand (`AWS_SECRET_ACCESS_KEY_ID`, `RESTIC_PASSWOR`, `_AWS_ACCESS_KEY_ID`). A config file removes that entire class of error and is a prerequisite for any script that runs unattended.

- Success criteria: `git status` shows `.env.example` tracked and `.env` ignored; sourcing the file lets `restic snapshots` run with no manual exports.

- What I did: Cloned the repo onto the VM, restored `~/ag3-testdata` from the Week 5 restore test, then created `config/.env` with all eight settings (MinIO credentials, endpoint, Restic keys, repository path and password, backup source). Set `chmod 600`, added it to `.gitignore`, and tested by sourcing the file and running `restic snapshots`.
  
- Decision made: Skipped the planned .env.example template — it was for Akib to rebuild MinIO on his own host, but the team is now connecting both machines via a physical switch instead

- Outcome: `restic snapshots` opened repository `5b3977bc` and listed the Week 5 snapshot (`99af232c`, 142 B) with zero manual exports. `git status` shows `config/.env` is invisible to git.

- What I learned: `export` only lasts one terminal session — a sourced config file loads everything at once, which is what makes unattended automation possible. `chmod 600` and `.gitignore` solve different problems (local users vs GitHub) and both are needed.



<img width="1339" height="836" alt="image" src="https://github.com/user-attachments/assets/9033f594-9b03-45a0-a8bd-8eea3fab8ed8" />

<img width="1335" height="814" alt="image" src="https://github.com/user-attachments/assets/b4adbbcf-9ff5-4c62-a5c9-9b07032d51c6" />


---

- [X] **Write automated backup script (#53)**

- What I plan to do: Write `scripts/backup.sh` to source the config file, run `restic backup` against the target data, run `restic check`, and log the result with a timestamp and exit code to `~/backup-logs/`. The script must exit non-zero on failure so the scheduler and Wazuh can detect it.

- Why this matters: A backup that only runs when I remember to type the command is not a backup strategy. Automation is what turns this into something the agribusiness could actually rely on, and the log output is what makes failures visible rather than silent.

- Success criteria: Running the script manually produces a new snapshot, a passing `restic check`, and a success log line. Breaking the credentials deliberately produces a non-zero exit and a logged failure.

- What I did: Created a `~/backup-logs/` folder for the log files, then wrote `scripts/backup.sh`. The script loads the config file from #45, takes the backup, then runs an integrity check, writing a timestamped line at each stage. Made it executable with `chmod +x` and ran it once by hand to test.
  
- Outcome: The script finished with exit code `0`. The log shows a new snapshot (`48b9e2fc`) was saved, and `restic check` reported no errors across both snapshots. The whole run took 2 seconds. I now have two backups stored: the Week 5 one and this one.
  
- What I learned: Restic doesn't copy everything again each time — it noticed the earlier snapshot and only stored what had changed, which is why 142 B of files only added about 1.3 KiB to the repository. I also learned that exit code 0 alone isn't proof of anything; it only says the script finished. Reading the log is what actually confirms a snapshot was created and the check passed. Because every run adds another snapshot, the repository will keep growing, which is exactly what the retention policy in #56 is for.

<img width="1462" height="161" alt="image" src="https://github.com/user-attachments/assets/4d8e3561-abc0-4464-8ad4-b5a81fa4228b" />

<img width="1391" height="871" alt="image" src="https://github.com/user-attachments/assets/497cb401-f5c3-4837-a3b8-a3dc6cd4a521" />

<img width="1374" height="488" alt="image" src="https://github.com/user-attachments/assets/71b93805-3094-4919-bfc2-56b7d788f5f5" />

<img width="1315" height="218" alt="image" src="https://github.com/user-attachments/assets/10f52ff4-ca53-41d2-9ed8-5627bb5583b8" />

---

- [ ] **Schedule backup every 4 hours (#54)**

- What I plan to do: Compare cron against systemd timers and record the reasoning for the choice, then schedule `backup.sh` to run every 4 hours and confirm it fires without manual intervention.

- Why this matters: The Project Proposal commits to an **RPO of 4 hours** — the maximum acceptable data loss. A 4-hourly schedule is what makes that number real rather than aspirational.

- Success criteria: At least two consecutive scheduled runs complete unattended, each producing a new snapshot and a log entry, verified with `restic snapshots` showing timestamps 4 hours apart.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Test deliberate backup failure (#55)**

- What I plan to do: Deliberately break the backup — invalid credentials, then an unreachable repository — and confirm the script exits non-zero and writes a clear failure entry to the log.

- Why this matters: A backup that fails silently is the exact risk this project exists to prevent, and it is worse than no backup because it creates false confidence. I need to see a failure correctly detected before I can trust a success.

- Success criteria: Both failure modes produce a non-zero exit code and a logged failure with a readable reason. Restoring valid settings returns the script to a passing run.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:






---

- [ ] **Apply retention policy (#56)**

- What I plan to do: Define a retention policy and apply it with `restic forget --prune`, keeping a set number of hourly, daily and weekly snapshots. Test with `--dry-run` first, then document the policy and reasoning in `config/`.

- Why this matters: Backing up every 4 hours indefinitely will fill the repository. Retention keeps enough recovery points to meet the RPO without unbounded growth, and `prune` reclaims the space.

- Success criteria: `--dry-run` output matches the intended policy before anything is deleted; snapshot count reduces to the target afterwards; `restic check` still passes.

- Note: `forget --prune` permanently deletes snapshots. Dry run first, every time.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Send backup status to Wazuh with Tanvi (#57)**

- What I plan to do: Agree a log format with Tanvi, write backup success and failure events where her Wazuh agent can read them, and confirm both event types appear in her dashboard.

- Why this matters: This is the first real integration point between my workstream and another team member's. A failed backup nobody notices is the same as no backup at all — monitoring closes that gap.

- Success criteria: A successful backup and a deliberately failed one both appear as distinguishable events in Wazuh.

- Dependency: Tanvi's Wazuh agent must be connected (her card #33). Soft dependency — I can produce the log output in the agreed format before her side is ready.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Refine #43 with scoped policy (#58)**

- What I plan to do: Create a MinIO policy granting `office-user1` legitimate access to a non-backup bucket while still denying `test-01-ag3-backups`, then repeat the access test with `mc`.

- Why this matters: The Week 6 test (#43) used a user with no policy at all, so it was denied everything rather than the backups specifically. A scoped policy proves the isolation is deliberate and targeted, which is a materially stronger claim against FR-08.

- Success criteria: `office-user1` can list the permitted bucket but still receives `Access Denied` on `test-01-ag3-backups`.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Coordinate network isolation test with Akib (#44) — BLOCKED**

**Blocker:** Requires Akib's VLAN and pfSense firewall configuration to be live. Akib and I work on separate laptops with no shared network, so this test must run on the host where the VLANs actually operate.

**Proposed approach:** Akib installs MinIO on his own host using my committed setup notes (`config/week-5-minio-restic-setup-faysal.md`) and places it on Backup VLAN 40 (10.20.40.10). He then tests reachability from an Office VLAN device (expected: blocked) and from the app server on Server VLAN 20 (expected: allowed on port 9000). Both results are needed — a denial proves nothing if nothing is listening at that address.

**Secondary benefit:** If Akib can stand up MinIO from my notes alone, that independently evidences **NFR-07** (another team member can rebuild the system from repository documentation).

**Status:** Dependency raised and documented. Will proceed as soon as his environment is testable.

---

## Evidence to collect this week

| Task | Status |
|---|---|
| `.env.example` committed, `.env` gitignored (`git status` screenshot) | Done |
| `scripts/backup.sh` committed | Done |
| Screenshot of successful manual script run + `restic check` |Done|
| Screenshot of scheduler configuration (cron/systemd timer) | |
| `restic snapshots` output showing two unattended runs 4 hours apart | |
| Log file showing deliberate failure with non-zero exit | |
| Retention policy documented + `--dry-run` and after-prune snapshot counts | |
| Wazuh dashboard screenshot showing backup events | |
| Scoped-policy isolation test result | |
| All committed to this folder with dated filenames | |
| Plan for Week 8 | |

---

## Risks for this week

1. **Scheduled job runs but silently fails.** Mitigation: #55 is a required card, not optional — a failure must be seen before a success is trusted.
2. **Wazuh integration depends on Tanvi's agent.** Mitigation: agree the log format early so my side is ready regardless of her timing.
3. **`restic forget --prune` is destructive.** Mitigation: `--dry-run` first, always, and verify the output before pruning.
4. **VLAN migration will change the endpoint.** When Akib's Backup VLAN 40 goes live, this server moves from 10.0.2.15 to 10.20.40.10. Keeping the endpoint in `config/.env` means one edit rather than hunting through scripts.
