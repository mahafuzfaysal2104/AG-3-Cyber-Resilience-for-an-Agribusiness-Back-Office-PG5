# Week 9 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, APP01 integration, and recovery\
**Week 9 goal:** Connect APP01 to the production MinIO repository on BKP01, verify the APP01 → MinIO backup path, prove that APP01 snapshots are visible from BKP01, complete a controlled restore from MinIO, and prepare for the later full production Nextcloud backup and Wazuh integration.

## Overall Project Contribution — Faysal (25%)

My assigned responsibility is **25% of the total group project**. The table below summarises the work I have completed and the work still remaining.

| Task Name                                                       | Description                                                                                                                                                                                                                             | Percentage of Work | Status                    | Proof / Detailed Evidence                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| --------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -----------------: | ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Week 4 – Project Proposal**                                   | Completed my assigned Backup & Recovery contribution to the proposal, including the communication/governance evidence plan, GitHub structure, Kanban conventions, AI-log/evidence process, and final integration checklist.             |          **1.00%** | **Done**                  | [Proposal Sections 16–18](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/docs/AG3_Faysal_Proposal_Sections_16_to_18.docx)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| **Week 4–5 – GitHub, Kanban & Implementation Plan**             | Set up and organised the GitHub repository, per-member evidence structure, GitHub Project/Kanban task tracking, and contributed to implementation planning for the Backup & Recovery workstream.                                        |          **2.50%** | **Done**                  | [Repository](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5) · [Kanban / Projects](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/projects) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal)                                                                                                                                                                                                                                                                                         |
| **Week 5 – MinIO & Restic Setup**                               | Built BKP01, installed and verified Restic and MinIO, created the MinIO backup bucket, initialised the encrypted Restic repository, backed up synthetic agribusiness data, and successfully restored it after deletion.                 |          **4.00%** | **Done**                  | [Week 5 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week%205.md) · [BKP01 environment](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/docs/Faysal/faysal-backup-environment.md) · [MinIO/Restic setup](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/config/Week-5-minio-restic-setup-faysal.md) · [Backup/restore results](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md) |
| **Week 6 – Progress Report 1**                                  | Completed my individual Progress Report 1 contribution covering Weeks 1–6, including proposal contribution, BKP01 build, Restic/MinIO setup, first backup/restore evidence, problems encountered, reflection, and remaining plan.       |          **0.75%** | **Done**                  | [Week 5 detailed evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week%205.md) · [Week 6 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week-6.md) · [Backup/restore results](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md)                                                                                                                                                                                     |
| **Week 6–7 – Backup Security & Automation**                     | Configured restricted MinIO access, protected `.env`, automated Restic backup and integrity checking, added JSON logging, configured four-hour cron scheduling, failure testing, retention, and MinIO service persistence.              |          **3.00%** | **Done**                  | [Week 6 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week-6.md) · [Week 7 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week-7.md) · [Backup script](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/scripts/backup.sh) · [AI log](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/AI-log.md)                                                                                               |
| **Week 8 – Connection with Akib**                               | Integrated BKP01 with Akib's network/pfSense environment, configured VLAN 40 addressing, tested the gateway/inter-VLAN path, and worked through network-isolation dependencies.                                                         |          **2.00%** | **Done**                  | [Network isolation task #44](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/44) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal)                                                                                                                                                                                                                                                                                                                                                                                              |
| **Week 9 – Progress Report 2**                                  | Completed my Progress Report 2 contribution for Weeks 7–9, documenting environment configuration, automated backup, four-hour schedule, retention, deliberate failure testing, Wazuh-compatible logging, and integration progress.      |          **0.75%** | **Done**                  | [Week 7 automation evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Week-7.md) · [Backup script](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/scripts/backup.sh) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal)                                                                                                                                                                                                                      |
| **Week 9 – Connection with Shourab / APP01 Backup & Restore** | Connected APP01 with BKP01/MinIO, verified TCP 9000 and the MinIO health endpoint, corrected the BKP01 return route, successfully sent controlled APP01 data to the production Restic repository, verified the APP01 snapshot from BKP01, restored the snapshot into an isolated recovery directory, and verified the restored data. | **2.50%** | **Done** | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Week 10 – Troubleshooting & Verification**                    | Investigated stale Restic locks, verified repository integrity, checked MinIO bucket/disk capacity, fixed Chrony time synchronisation, investigated the MinIO restart, and saved the APP01 return route persistently in NetworkManager. |          **1.50%** | **Done**                  | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal)                                                                                                                                                                                                                                                                                                                                                                                              |
| **Weeks 5–10 – Weekly GitHub Evidence & Documentation**         | Maintained Weekly GitHub evidence, screenshots, commands, Kanban task records, troubleshooting notes, AI transparency records, and technical documentation for the Backup & Recovery workstream.                                        |          **1.50%** | **Done**                  | [All Faysal evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) · [AI log](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/AI-log.md) · [Repository history](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/commits/main)                                                                                                                                                                                                                                                                       |
| **Week 10 – Full Production Nextcloud Backup** | The controlled APP01 → MinIO backup and restore path is proven. The remaining work is to verify a completed production-scale snapshot of the actual Nextcloud data/application set, rather than only controlled test data. | **1.25%** | **In Progress** | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) |
| **Week 10–11 – Connection with Tanvi / Wazuh**                  | Connect BKP01 backup/security events to Tanvi's MON01/Wazuh. BKP01 JSON logging is prepared, but end-to-end monitoring is waiting on MON01 connectivity.                                                                                |          **0.75%** | **In Progress / Blocked** | [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) · [Search Wazuh tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+wazuh+backup)                                                                                                                                                                                                                                                                                                                                                                               |
| **Week 11 – Encryption/Data-Loss Simulation + Wazuh Detection** | After the full Nextcloud backup is stable, run a controlled data-loss/encryption simulation and prove that Wazuh detects the event.                                                                                                     |          **1.00%** | **In Progress**           | [Search simulation tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+simulation+backup)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| **Week 11 – Manual Restore from MinIO**                         | Select a clean Restic snapshot from MinIO, restore the affected Nextcloud data manually, and verify restored files by content/hash/file count.                                                                                          |          **0.75%** | **In Progress**           | [Initial restore proof](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md) · [Search restore tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+restore+minio)                                                                                                                                                                                                                                                                                                                                                      |
| **Final Week – Final Report**                                   | Complete my Backup & Recovery contribution to the final report, including implementation evidence, integration results, troubleshooting, security justification, recovery results, and RTO/RPO evaluation.                              |          **1.00%** | **In Progress**           | Evidence link will be added after the final report is committed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Final Week – Presentation**                                   | Prepare and present my Backup & Recovery contribution, architecture, APP01>MinIO integration, Wazuh detection flow, recovery demonstration, and final results.                                                                          |          **0.75%** | **In Progress**           | Evidence link will be added after presentation material is committed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| **TOTAL**                                                       | **My total assigned contribution to the group project**                                                                                                                                                                                 |         **25.00%** | —                         | [Repository evidence index](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

### Current Progress

| Progress                       |     Amount |
| ------------------------------ | ---------: |
| **My total assigned share**    | **25.00%** |
| **Completed**                  | **19.50%** |
| **Remaining**                  |  **5.50%** |
| **My assigned work completed** |    **78%** |
| **My assigned work remaining** |    **22%** |

**Remaining dependency flow:**\
**Verify full production Nextcloud snapshot > Tanvi/Wazuh connection > encryption/data-loss simulation + Wazuh detection > restore the last clean MinIO snapshot > final report > presentation**

---

## Planned tasks (Kanban board)

| # | Task | Status |
|---|---|---|
| 1 | Restricted `backup-administrator` user and policy | Done |
| 2 | Production bucket access and isolation (allowed and denied tests) | Done |
| 3 | Restic backup using restricted credentials | Done |
| 4 | Production backup automation | Done |
| 5 | BKP01 VLAN 40 configuration | Done |
| 6 | APP01 → BKP01 TCP 9000 connection and MinIO health HTTP 200 | Done |
| 7 | Wrong return route corrected and persistent VLAN 20 route saved | Done |
| 8 | APP01 backup snapshot visible from BKP01 | Done |
| 9 | APP01 → MinIO Nextcloud backup, snapshot verification, and successful recovery | Done |
| 10 | Production repository integrity check | Done |
| 11 | Full `/var/ncdata` production snapshot verification | Pending |
| 12 | Wazuh dashboard backup event | Pending |

---

## Week 9 task list

- [x] **Restricted `backup-administrator` user and policy**

- **What I did:** Created `backup-administrator` and attached the custom policy `ag3-restic-backup`.

- **Why I need to do this:** APP01 should not use MinIO root credentials. It only needs access to the production backup bucket.

- **Problem and Solution:** The original backup configuration used administrator credentials. I replaced them with a restricted account.

- **Justification:** This follows least privilege and reduces the impact if APP01 credentials are compromised.

- **Code used:**

```bash
mc admin user info localminio backup-administrator
mc admin policy info localminio ag3-restic-backup
```

**What this code does:** The first command checks the restricted MinIO user. The second command displays the policy attached to that user so I can confirm its permissions.

<img width="2143" height="1200" alt="image" src="https://github.com/user-attachments/assets/079ebe5d-25cc-4bea-a842-48cc232dad26" />
- **Screenshot:** User enabled with `PolicyName: ag3-restic-backup`, plus the scoped policy.

---

- [x] **Production bucket access and isolation (allowed and denied tests)**

- **What I did:** Tested the restricted account against the production bucket, the old test bucket, and MinIO administration.

- **Why I need to do this:** I needed to prove that the account can do backup work but cannot access unrelated resources.

- **Problem and Solution:** The production bucket worked correctly. The old test bucket and admin commands returned `Access Denied`, which is the expected result.

- **Justification:** A security control should prove both allowed access and denied access.

- **Code used:**

```bash
mc ls backup-test/ag3-plains-pastoral-backups
mc ls backup-test/test-01-ag3-backups
mc admin user ls backup-test
```

**What this code does:** These commands test what the restricted account can and cannot access. The first should work, while the second and third should be denied.

<img width="2114" height="222" alt="image" src="https://github.com/user-attachments/assets/7a36602e-b3b5-4ac5-94cc-ac06f272a90d" />
- **Screenshot:** Production bucket allowed; test bucket and admin command denied.

---

- [x] **Restic backup using restricted credentials**

- **What I did:** Used the restricted account to open the production repository, create a Restic snapshot, and run an integrity check.

- **Why I need to do this:** Manual MinIO tests are not enough. The real application, Restic, must work using the restricted account.

- **Problem and Solution:** No permission problem occurred after the correct policy was attached.

- **Justification:** This proves that the least-privilege policy is sufficient for the real backup workflow.

- **Code used:**

```bash
restic snapshots
restic backup ~/ag3-testdata
restic check
```

**What this code does:** These commands list existing backups, create a test backup, and then check the repository for errors.

<img width="1527" height="407" alt="image" src="https://github.com/user-attachments/assets/9ceccb13-a050-404b-9f51-39ea94fa7d79" />
- **Screenshot:** Production repository `d1f8bc5e`, snapshot created, and `no errors were found`.

---

- [x] **Production backup automation**

- **What I did:** Updated the production `.env` to use `backup-administrator`, reloaded the configuration, and ran the real backup script.

- **Why I need to do this:** The real automation must use the same restricted credentials that passed our manual tests.

- **Problem and Solution:** Temporary environment variables could hide configuration errors, so the real `.env` was reloaded before testing.

- **Justification:** This confirms that the automated workflow, not only manual commands, uses the production configuration.

- **Code used:**

```bash
set -a; source config/.env; set +a
./scripts/backup.sh
echo "Exit: $?"
restic snapshots
```

**What this code does:** The first command loads the backup settings from `.env`. The script then runs the backup job, checks the exit code for success or failure, and verifies that a snapshot was created.

<img width="1629" height="429" alt="image" src="https://github.com/user-attachments/assets/4d84ad77-1467-44f5-b131-bd8f217fc428" />
- **Screenshot:** Script exit code `0` and production snapshots.

---

- [x] **BKP01 VLAN 40 configuration**

- **What I did:** Confirmed BKP01 uses `10.20.40.10/24` on `enp0s8`, confirmed the VLAN 40 gateway, and tested APP01 connectivity.

- **Why I need to do this:** APP01 cannot push backups to BKP01 unless the VLAN and gateway configuration are correct.

- **Problem and Solution:** BKP01 had the correct VLAN 40 address and could reach the gateway and APP01.

- **Justification:** Network connectivity must be verified before troubleshooting Restic or MinIO.

- **Code used:**

```bash
ip -br addr
ping -c 4 10.20.40.1
ping -c 4 10.20.20.10
```

**What this code does:** These commands show BKP01's IP addresses, test the VLAN 40 gateway, and test communication with APP01.



- **Screenshot:** `enp0s8` with `10.20.40.10/24` and successful gateway test.

---

- [x] **APP01 → BKP01 TCP 9000 connection and MinIO health HTTP 200**

- **What I did:** Confirmed MinIO was listening on TCP 9000 and tested the real service connection from APP01.

- **Why I need to do this:** Restic on APP01 sends backup data to MinIO on BKP01 using TCP 9000.

- **Problem and Solution:** The first TCP test timed out. Packet capture showed APP01 SYN packets reaching BKP01, so the firewall path was working. The real problem was the BKP01 return route.

- **Justification:** Testing the real service port gives stronger evidence than ping alone.

- **Code used:**

On BKP01:

```bash
sudo ss -lntp | grep ':9000'
sudo tcpdump -ni enp0s8 tcp port 9000
```

**What this code does:** The first command confirms that MinIO is listening on TCP port 9000. The second watches backup traffic arriving on the VLAN 40 interface.

On APP01:

```bash
nc -zv -w 5 10.20.40.10 9000
curl -I http://10.20.40.10:9000/minio/health/live
```

**What this code does:** `nc` checks whether APP01 can reach MinIO on TCP 9000. `curl` checks whether the MinIO service itself is alive and responding.

- **Screenshot:** Successful TCP 9000 connection and `HTTP/1.1 200 OK`.

---

- [x] **Wrong return route corrected and persistent VLAN 20 route saved**

- **What I did:** Checked the route from BKP01 to APP01 and found that Linux was replying through the VirtualBox NAT interface instead of VLAN 40. I corrected the route and saved it in NetworkManager.

- **Why I need to do this:** APP01 traffic arrived at BKP01, but BKP01 must send replies back through the correct project network.

- **Problem and Solution:** The wrong path was `10.0.2.2` through `enp0s3`. I changed the APP01 subnet route to use `10.20.40.1` through `enp0s8`.

- **Justification:** Correct return routing is required for a TCP session to complete successfully.

- **Code used:**

```bash
ip route get 10.20.20.10
sudo ip route replace 10.20.20.0/24 via 10.20.40.1 dev enp0s8
sudo nmcli connection modify "Wired connection 1"   +ipv4.routes "10.20.20.0/24 10.20.40.1"
nmcli -g ipv4.routes connection show "Wired connection 1"
```

<img width="1797" height="148" alt="image" src="https://github.com/user-attachments/assets/ea9b6a49-50a6-42c7-8844-86abc8a8ded5" />
- **Screenshot:** Wrong route before the fix and saved route `10.20.20.0/24 10.20.40.1`.

---

- [x] **APP01 backup snapshot visible from BKP01**

- **What I did:** Checked the production repository from BKP01 and confirmed that a completed APP01 backup snapshot was stored in the production MinIO-backed Restic repository.

- **Why I need to do this:** This proves that APP01 can successfully push backup data through pfSense to MinIO on BKP01.

- **Problem and Solution:** Earlier APP01 backup attempts had connectivity and sustained-transfer problems. After correcting the routing and confirming TCP 9000, a controlled APP01 snapshot was successfully stored and could be verified from BKP01.

- **Justification:** This proves that APP01 can successfully write to the same production Restic repository hosted by MinIO on BKP01.

- **Code used:**

```bash
cd ~/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5
set -a
source config/.env
set +a

restic snapshots --host app01
```

**What this code does:** This filters the Restic snapshot list so I can see only backups created by APP01.

<img width="1453" height="270" alt="image" src="https://github.com/user-attachments/assets/1769082f-dd40-49f4-a8f6-7f6b319631e1" />
- **Screenshot:** APP01 snapshot `e7d7787b` from `/home/shourab/restic-test`.

---

- [x] **APP01 → MinIO Nextcloud backup, snapshot verification, and successful recovery**

- **What I did:** Completed a controlled end-to-end backup and restore test between APP01 and BKP01. APP01 created backup data in the production Restic repository, BKP01 verified the APP01 snapshot, and the backed-up data was restored into a separate recovery directory without overwriting live Nextcloud data.

- **Why I need to do this:** A backup system is only useful if stored data can also be recovered successfully. This test proves both the backup and recovery directions.

- **Problem and Solution:** Earlier testing was blocked by TCP routing problems and MinIO `PutObject` timeouts. After correcting the BKP01 return route, confirming TCP 9000 connectivity, and using the controlled Restic workflow, the backup and restore test completed successfully.

- **Justification:** This proves the complete technical path: **APP01 → Restic → MinIO/BKP01 → snapshot verification → isolated restore**. The successful controlled test proves the mechanism works, but it is kept separate from the later production-scale `/var/ncdata` verification.

- **Code used on APP01:**

```bash
restic -o s3.connections=1 snapshots
restic -o s3.connections=1 backup ~/ag3-backup-test --tag shourav-test
sha256sum ~/ag3-backup-test/shourav-test.txt
```

**What this code does:** APP01 checks the shared Restic repository, creates a controlled backup using reduced S3 concurrency, and calculates the original file hash for later verification.

- **Code used on BKP01:**

```bash
restic -o s3.connections=1 snapshots --tag shourav-test
restic ls <SNAPSHOT_ID>
restic -o s3.connections=1 restore <SNAPSHOT_ID> --target ~/ag3-shourav-restore-test
find ~/ag3-shourav-restore-test -name "shourav-test.txt" -exec sha256sum {} \;
restic -o s3.connections=1 check
```

**What this code does:** BKP01 verifies the APP01 snapshot, checks its contents, restores it into an isolated folder, calculates the restored file hash, and checks repository integrity.

- **Additional Nextcloud database recovery verified by Shourav:** Snapshot `ae4a98fe` in repository `d1f8bc5e` included `/var/www/nextcloud` and `/opt/nextcloud-backup`. Shourav restored the real SQL dump on APP01 with the following command:

```bash
mkdir -p ~/restic-restore-test
/tmp/restic_0.19.1_linux_arm64 \
  -o s3.connections=1 \
  restore ae4a98fe \
  --target ~/restic-restore-test \
  --include /opt/nextcloud-backup/nextcloud-db.sql

ls -lh ~/restic-restore-test/opt/nextcloud-backup/nextcloud-db.sql
```

**Result:** Restic reported `Restored 3 / 1 files/dirs (3.063 MiB / 3.063 MiB)`, and the recovered `nextcloud-db.sql` file appeared as approximately 3.1 MB. This verifies recovery of the database dump into an isolated folder, not a live database import or complete application restart.


<img width="1323" height="756" alt="image" src="https://github.com/user-attachments/assets/da4dbd7b-793d-4848-90ea-37586165a124" />

- **Screenshot:** Add Shourav's successful database-restore screenshot here; leave all existing screenshot code unchanged.

---


- [x] **Production repository integrity check**

- **What I did:** Investigated an old Restic lock left by the interrupted APP01 backup, removed the stale lock, and ran a repository integrity check.

- **Why I need to do this:** A stale lock can stop repository maintenance and verification.

- **Problem and Solution:** APP01 had stopped or disconnected before the previous large backup completed, leaving a stale lock. After clearing it, `restic check` passed.

- **Justification:** I must confirm that the repository is healthy before starting another large backup.

- **Code used:**

```bash
restic list locks
restic unlock
restic check
```

**What this code does:** These commands show repository locks, remove stale locks that are no longer needed, and then verify that the repository is healthy.

<img width="1104" height="340" alt="image" src="https://github.com/user-attachments/assets/55e3f127-b579-46e2-9aef-3b509db60bcd" />
- **Screenshot:** Lock information and final integrity check showing `8 / 8 snapshots` with no errors.

---

- [ ] **Full `/var/ncdata` production snapshot verification**

- **What I did:** The APP01 → MinIO backup and restore mechanism has been successfully proven using controlled APP01 data. APP01 can reach MinIO, write to the production Restic repository, BKP01 can see the snapshot, and the snapshot can be restored successfully.

- **Why I need to do this:** The final project must also verify that the same workflow can protect the actual production Nextcloud dataset, not only a controlled test directory.

- **Problem and Solution:** Earlier production-scale attempts involving the real Nextcloud data experienced routing and `PutObject` timeout problems. The routing problem is now corrected and the controlled backup/restore workflow is working. The remaining evidence required is a completed snapshot containing the actual Nextcloud data path.

- **Justification:** The completed controlled restore proves the technical recovery mechanism. A separate completed production snapshot is still required before claiming that the full Nextcloud production backup is finished.

- **Production backup command on APP01:**

```bash
sudo -E restic -o s3.connections=1 backup \
  /var/ncdata \
  --tag app01 \
  --tag nextcloud \
  --tag production
```

- **Verification on BKP01:**

```bash
restic snapshots --host app01
restic ls <PRODUCTION_SNAPSHOT_ID>
restic check
```

**What this code does:** APP01 backs up the actual Nextcloud data path to the MinIO-backed Restic repository. BKP01 then verifies that the production snapshot exists, inspects its contents, and confirms repository integrity.

- **Success criteria:** A completed APP01 snapshot containing `/var/ncdata` must appear in the production repository without transfer errors.

- **Current status:** **Pending verification for `/var/ncdata`** — APP01 controlled backup and Nextcloud SQL-dump recovery are complete; the supplied restore output does not list `/var/ncdata` among snapshot `ae4a98fe`'s source paths.

- **Screenshot:** Add the completed `/var/ncdata` production snapshot and `restic ls` output when available.

---

- [ ] **Wazuh dashboard backup event**

- **What I did:** BKP01 already writes backup events to `/var/log/cyber-resilience/backup.json`.

- **Why I need to do this:** Tanvi's Wazuh server needs to detect successful and failed backups centrally.

- **Problem and Solution:** MON01 was not reachable during the previous test session, so the Wazuh agent integration is still pending.


** Moved to Week 10**


---

## Evidence collected this Week

| Task | Status |
|---|---|
| Restricted `backup-administrator` user and policy | Done |
| Production bucket access and isolation (allowed and denied tests) | Done |
| Restic backup using restricted credentials | Done |
| Production backup automation | Done |
| Production repository integrity check | Done |
| BKP01 VLAN 40 configuration | Done |
| APP01 → BKP01 TCP 9000 connection and MinIO health HTTP 200 | Done |
| Wrong return route corrected and persistent VLAN 20 route saved | Done |
| APP01 backup snapshot visible from BKP01 | Done |
| APP01 → MinIO Nextcloud backup, snapshot verification, and successful recovery (including controlled test data and `nextcloud-db.sql`) | Done |
| Full `/var/ncdata` production snapshot verification | Pending (Week 10) |
| Wazuh dashboard backup event | Pending (Week 10) |

---

## Carried over to Week 10

- Verify a completed **full `/var/ncdata` production snapshot** from APP01.
- Confirm the production snapshot contents from BKP01 using `restic ls`.
- Configure the **production APP01 backup schedule every 4 hours** after the production backup is stable.
- Connect BKP01 JSON backup logs to **MON01/Wazuh**.
- Run the controlled ransomware/data-loss simulation after a known-good clean production snapshot exists.
- Verify Wazuh detects the simulated mass file changes.
- Restore the last clean MinIO/Restic snapshot after the simulation.
- Measure recovery time against the project RTO.
- Complete the final network-isolation test with Akib.
