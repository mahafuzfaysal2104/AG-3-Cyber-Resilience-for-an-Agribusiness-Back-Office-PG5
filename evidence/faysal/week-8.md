# Week 8 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, automation, and recovery

## Two-week plan: Weeks 8 and 9

The aim across these two weeks is to **finish every outstanding build task by the end of Week 9**, then move from building to verifying. Week 8 closes the remaining integration work. Week 9 confirms everything actually works together and begins preparing the recovery simulation.

| Week | Focus |
|---|---|
| **Week 8** | Finish all remaining build and integration tasks (#58, #59, #62, #57, #63, #44) |
| **Week 9** | Verify everything works end to end, submit Progress Report 2, and begin planning the recovery simulation |
| Week 10 | Run the mentor-approved data-loss simulation and full team rehearsal |
| Week 11 | Timed recovery, RTO/RPO measurement, integrity verification |

**Why this split:** every task in Week 8 is something being *built*. Everything from Week 9 onwards is something being *proven*. Mixing the two is how projects arrive at Week 12 with features that were never tested.

## Kanban board — Week 8

| # | Card | Depends on |
|---|---|---|
| #58 | Refine #43 with scoped policy | — |
| #59 | Document backup ports and access rules for Akib | — |
| #62 | Re-verify backup and restore after IP change | `.env` update |
| #57 | Wazuh agent install + backup events in dashboard | Inter-VLAN connectivity, Tanvi |
| #63 | Back up real Nextcloud data | Inter-VLAN connectivity, Shourab |
| #44 | Coordinate network isolation test with Akib | Inter-VLAN connectivity, Akib |

**Critical path:** three of these six are blocked by the same thing — inter-VLAN connectivity, which failed in the Week 7 lab session. Solving that early converts a blocked week into a productive one.

---

## Week 8 task list

- [ ] **Update endpoint and re-verify backup (#62)**

- What I plan to do: Change `MINIO_ENDPOINT` and `RESTIC_REPOSITORY` in `config/.env` from `127.0.0.1` to `10.20.40.10`, update the `mc` alias, then re-run the full pipeline — snapshots, backup script, and a restore.

- Why this matters: The backup currently works only because MinIO happens to be on the same machine. Nothing has been tested across a real network interface. If the address change breaks something, better to find out now than during the simulation.

- Success criteria: `restic snapshots` opens the repository over 10.20.40.10, `backup.sh` exits 0, and a restore recovers files with matching contents.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Refine credential isolation test with a scoped policy (#58)**

- What I plan to do: Create a MinIO policy granting `office-user1` legitimate read access to a non-backup bucket while still denying `test-01-ag3-backups`, then repeat the access test with `mc`.

- Why this matters: The Week 6 test used a user with no policy at all, so it was denied everything rather than the backups specifically. A realistic office account would have access to *something*. Proving the denial is targeted rather than blanket is a stronger claim against FR-08.

- Success criteria: `office-user1` can list the permitted bucket but still receives `Access Denied` on `test-01-ag3-backups`.

- Note: No dependency on anyone else — the safe card to do if network work stalls.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Document backup ports and access rules for Akib (#59)**

- What I plan to do: Write `docs/Faysal/backup-network-requirements.md` specifying what pfSense must allow and deny for BKP01 (10.20.40.10): TCP 9000 inbound from APP01 10.20.20.10 only, TCP 9001 inbound from Management VLAN 99 only, all traffic from Office VLAN 10 denied.

- Why this matters: Akib confirmed these verbally, but they exist only in a Teams message. Committing them makes them reviewable, versioned, and available as evidence of cross-workstream coordination.

- Also resolve: whether ICMP is permitted between VLANs. Ping failed in the Week 7 lab, and since Akib's rules only mention TCP 9000 and 9001, a blocked ping may be correct behaviour. This changes how every connectivity test is interpreted, so it needs stating explicitly.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Install Wazuh agent and confirm backup events (#57)**

- What I plan to do: Install the Wazuh agent on the backup VM, point it at MON01 (10.20.30.10), configure it to read `/var/log/cyber-resilience/backup.json` as JSON, then run one successful and one failed backup and confirm both appear in Tanvi's dashboard.

- Why this matters: My side is already done — the script writes correct JSON in Tanvi's agreed format. But a log nobody reads is not monitoring. Her agent cannot read a file on another machine, so the agent has to run here.

- Success criteria: Success and failure events both visible and distinguishable in Wazuh, with different severities.

- Dependency: MON01 reachable from VLAN 40.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Back up real Nextcloud data (#63)**

- What I plan to do: Get the Nextcloud data path from Shourab, agree how Restic reads it over the network (SSH key or mount), update `BACKUP_SOURCE`, and run a backup and restore against real data.

- Why this matters: Every test so far used three synthetic files totalling 142 bytes. That proves the mechanism but says nothing about real volume, permissions or file structures. The Week 10 simulation and Week 11 timed recovery both need real data to mean anything.

- Success criteria: A snapshot containing actual Nextcloud content, verified with `restic ls latest`, and a successful restore.

- Dependency: APP01 reachable, data path from Shourab, read access arranged, and **actual files present** — he has created folders but not yet added data.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

- [ ] **Coordinate network isolation test with Akib (#44)**

- What I plan to do: With Akib, test reachability to BKP01 from an Office VLAN 10 device (expected: blocked) and from APP01 on Server VLAN 20 (expected: allowed on TCP 9000). Capture the firewall denial log.

- Why this matters: This is the network half of FR-08. Card #43 proved a stolen password cannot reach the backups; this proves a compromised office machine cannot either.

- Why both results are needed: A blocked connection proves nothing alone — it looks identical to a server that is switched off. The allowed path must work at the same time for the denial to mean anything.

- Dependency: Inter-VLAN routing working.

- What I did:
- Issues faced and fixed:
- Outcome:
- What I learned:

---

## Blocker to resolve first — inter-VLAN connectivity

Carried from Week 7. My server reached its own gateway (10.20.40.1) with 0% packet loss, but 10.20.20.10 and 10.20.30.10 both returned 100% loss. Neither Shourab nor Tanvi could reach their own gateways either.

**What we know:**
- My VLAN 40 configuration is correct and verified.
- `nc -zv 10.20.20.10 22` returned **Connection refused** rather than a timeout — something answered at that address, so the path is not completely dead.
- Ping is an unreliable test here; Akib's rules cover TCP 9000/9001 and do not mention ICMP.

**Questions to answer:**
1. Is ICMP permitted between VLANs, or should we test with `nc` on specific ports?
2. Were APP01 and MON01 actually running and correctly addressed?
3. Is inter-VLAN routing enabled on pfSense, or is each VLAN isolated by default?

---

## Week 9 — verification and simulation planning

Week 9 has three parts: confirming everything built so far actually works, submitting Progress Report 2, and preparing the recovery simulation.

### Part 1 — Verify everything works together

Nothing new is built. Every claim made so far gets checked end to end:

| Check | How |
|---|---|
| Scheduled backups actually ran unattended | `restic snapshots` showing runs 4 hours apart over several days |
| Repository is healthy | `restic check` with no errors |
| Failures are detected | Deliberate failure produces a Wazuh alert, not just a log line |
| Retention is working | Snapshot count stays bounded as new backups accumulate |
| Real data is being backed up | `restic ls latest` shows Nextcloud content, not test files |
| Restore works from the network address | Full restore, contents verified against the source |
| Isolation holds | Office VLAN blocked, APP01 allowed, both evidenced |

Anything that fails here gets fixed in Week 9, not Week 11.

### Part 2 — Progress Report 2 (due Monday Week 9)

Same structure as Progress Report 1, covering Weeks 7 to 9: automation delivered ahead of the OBJ-05 target, network integration, and the cross-workstream connections with Tanvi and Akib.

### Part 3 — Plan the recovery simulation

**Approach: simulate the loss, not the attack.** What needs proving is that data can be recovered within the RTO after it disappears or becomes unreadable. That does not require real ransomware — and running real malware on a shared campus network would be both unnecessary and unacceptable. The simulation reproduces the *effect* using a controlled script I write myself.

This is the same thing I did on a small scale in Week 5, when I ran `rm -rf ~/ag3-testdata` and restored from the snapshot. Week 10 is that test at full scale, timed and documented.

**What I need to learn and prepare this week:**

1. **How ransomware causes data loss** — background reading only, to make the simulation realistic. The relevant behaviour is that files are encrypted or deleted, often across a whole share, and that attackers commonly target backups too. That last point is exactly why VLAN isolation (#44) and credential isolation (#43, #58) matter.

2. **Write the simulation script.** A controlled script that renders a *copy* of the test data unreadable — encrypting files with a key I hold, or deleting them — on a designated target directory only, never touching the MinIO repository. It needs a hard-coded safe path and a confirmation prompt so it cannot run anywhere unintended.

3. **Write the recovery runbook.** The steps someone follows to restore: identify the last clean snapshot, verify it, restore, confirm file counts and hashes. This gets tested in Week 10 and finalised in Week 11.

4. **Get mentor approval before running anything.** Dr Sabrina approves the simulation plan, the safe path, and the scope before Week 10. The plan is written and submitted this week.

5. **Define what gets measured.** RTO (time from loss to verified restore) against the 2-hour target, RPO (data lost against the 4-hour target), file count match, and SHA-256 comparison of restored files against originals.

**Safety rules, non-negotiable:**
- Runs only against a designated test directory, never live team data
- Never runs on the MinIO repository or Backup VLAN 40
- No self-spreading behaviour of any kind — it is a script that runs once, where I run it
- A verified snapshot exists before the simulation starts
- Mentor approval obtained in writing beforehand
- Whole team informed before it runs

---

## Evidence to collect — Weeks 8 and 9

| Task | Status |
|---|---|
| `.env` updated to 10.20.40.10 | |
| Backup + restore working over the network address | |
| Scoped MinIO policy committed and tested | |
| `backup-network-requirements.md` committed | |
| Wazuh agent connected to MON01 | |
| Wazuh dashboard showing success and failure events | |
| `restic ls latest` showing real Nextcloud files | |
| Firewall denial log from Office VLAN test | |
| Successful connection from APP01 on TCP 9000 | |
| `restic snapshots` showing unattended 4-hourly runs over several days | |
| Simulation plan submitted to mentor | |
| Recovery runbook drafted | |
| Progress Report 2 submitted | |
| Plan for Week 10 | |

---

## Risks

1. **Inter-VLAN connectivity may not be resolved quickly.** Mitigation: #58 and #59 need nobody else, so productive work is always available. Raise the network problem at the start of the week, not the next lab session.
2. **Real Nextcloud data may not exist.** Shourab has folders but no files. Ask before the session, not on the day.
3. **Week 9 carries both Progress Report 2 and verification work.** Mitigation: keep the build work inside Week 8. Anything slipping into Week 9 compresses the report.
4. **Simulation needs mentor approval before Week 10.** Mitigation: submit the plan in Week 9, not Week 10 — approval is not instant.
5. **The recovery runbook is untested until Week 10.** Mitigation: draft it in Week 9 so the Week 10 rehearsal tests it rather than writing it under time pressure.
