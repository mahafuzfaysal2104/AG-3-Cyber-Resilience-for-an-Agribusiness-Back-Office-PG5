# Week 10 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, APP01 integration, and recovery  
**Iek 10 goal:** Connect APP01 to the production MinIO repository on BKP01, apply least-privilege access, verify the real backup path, and prepare for the full Nextcloud backup and Wazuh integration.


## Overall Project Contribution — Faysal (25%)

My assigned responsibility is **25% of the total group project**. The table below summarises the work I have completed and the work still remaining.

| Task Name | Description | Percentage of Work | Status | Proof / Detailed Evidence |
| --- | --- | ---: | --- | --- |
| **Iek 4 – Project Proposal** | Completed my assigned Backup & Recovery contribution to the proposal, including the communication/governance evidence plan, GitHub structure, Kanban conventions, AI-log/evidence process, and final integration checklist. | **1.00%** | **Done** | [Proposal Sections 16–18](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/docs/AG3_Faysal_Proposal_Sections_16_to_18.docx) |
| **Iek 4–5 – GitHub, Kanban & Implementation Plan** | Set up and organised the GitHub repository, per-member evidence structure, GitHub Project/Kanban task tracking, and contributed to implementation planning for the Backup & Recovery workstream. | **2.50%** | **Done** | [Repository](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5) · [Kanban / Projects](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/projects) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Iek 5 – MinIO & Restic Setup** | Built BKP01, installed and verified Restic and MinIO, created the MinIO backup bucket, initialised the encrypted Restic repository, backed up synthetic agribusiness data, and successfully restored it after deletion. | **4.00%** | **Done** | [Iek 5 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek%205.md) · [BKP01 environment](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/docs/Faysal/faysal-backup-environment.md) · [MinIO/Restic setup](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/config/Iek-5-minio-restic-setup-faysal.md) · [Backup/restore results](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md) |
| **Iek 6 – Progress Report 1** | Completed my individual Progress Report 1 contribution covering Ieks 1–6, including proposal contribution, BKP01 build, Restic/MinIO setup, first backup/restore evidence, problems encountered, reflection, and remaining plan. | **0.75%** | **Done** | [Iek 5 detailed evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek%205.md) · [Iek 6 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek-6.md) · [Backup/restore results](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md) |
| **Iek 6–7 – Backup Security & Automation** | Configured restricted MinIO access, protected `.env`, automated Restic backup and integrity checking, added JSON logging, configured four-hour cron scheduling, failure testing, retention, and MinIO service persistence. | **3.00%** | **Done** | [Iek 6 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek-6.md) · [Iek 7 evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek-7.md) · [Backup script](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/scripts/backup.sh) · [AI log](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/AI-log.md) |
| **Iek 8 – Connection with Akib** | Integrated BKP01 with Akib's network/pfSense environment, configured VLAN 40 addressing, tested the gateway/inter-VLAN path, and worked through network-isolation dependencies. | **2.00%** | **Done** | [Network isolation task #44](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/44) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Iek 9 – Progress Report 2** | Completed my Progress Report 2 contribution for Ieks 7–9, documenting environment configuration, automated backup, four-hour schedule, retention, deliberate failure testing, Wazuh-compatible logging, and integration progress. | **0.75%** | **Done** | [Iek 7 automation evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/evidence/faysal/Iek-7.md) · [Backup script](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/scripts/backup.sh) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Iek 9–10 – Connection with Shourab** | Opened and tested the APP01/Nextcloud > BKP01/MinIO path, diagnosed TCP 9000 timeout behaviour, corrected the return route, verified MinIO health, and received a successful small Restic backup from APP01. | **2.50%** | **Done** | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Iek 10 – Troubleshooting & Verification** | Investigated stale Restic locks, verified repository integrity, checked MinIO bucket/disk capacity, fixed Chrony time synchronisation, investigated the MinIO restart, and saved the APP01 return route persistently in NetworkManager. | **1.50%** | **Done** | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) · [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |
| **Ieks 5–10 – Iekly GitHub Evidence & Documentation** | Maintained Iekly GitHub evidence, screenshots, commands, Kanban task records, troubleshooting notes, AI transparency records, and technical documentation for the Backup & Recovery workstream. | **1.50%** | **Done** | [All Faysal evidence](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) · [AI log](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/AI-log.md) · [Repository history](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/commits/main) |
| **Iek 10 – Full Nextcloud Backup** | Complete a stable large Nextcloud backup from APP01 to MinIO, eliminate the current sustained-transfer/`PutObject` problem, and verify a completed full APP01 production snapshot. | **1.25%** | **In Progress** | [Nextcloud > MinIO task #64](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues/64) |
| **Iek 10–11 – Connection with Tanvi / Wazuh** | Connect BKP01 backup/security events to Tanvi's MON01/Wazuh. BKP01 JSON logging is prepared, but end-to-end monitoring is waiting on MON01 connectivity. | **0.75%** | **In Progress / Blocked** | [Faysal evidence folder](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) · [Search Wazuh tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+wazuh+backup) |
| **Iek 11 – Encryption/Data-Loss Simulation + Wazuh Detection** | After the full Nextcloud backup is stable, run a controlled data-loss/encryption simulation and prove that Wazuh detects the event. | **1.00%** | **In Progress** | [Search simulation tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+simulation+backup) |
| **Iek 11 – Manual Restore from MinIO** | Select a clean Restic snapshot from MinIO, restore the affected Nextcloud data manually, and verify restored files by content/hash/file count. | **0.75%** | **In Progress** | [Initial restore proof](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/blob/main/testing/backup-restore-test-results.md) · [Search restore tasks](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/issues?q=is%3Aissue+restore+minio) |
| **Final Iek – Final Report** | Complete my Backup & Recovery contribution to the final report, including implementation evidence, integration results, troubleshooting, security justification, recovery results, and RTO/RPO evaluation. | **1.00%** | **In Progress** | Evidence link will be added after the final report is committed. |
| **Final Iek – Presentation** | Prepare and present my Backup & Recovery contribution, architecture, APP01>MinIO integration, Wazuh detection flow, recovery demonstration, and final results. | **0.75%** | **In Progress** | Evidence link will be added after presentation material is committed. |
| **TOTAL** | **My total assigned contribution to the group project** | **25.00%** | — | [Repository evidence index](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5/tree/main/evidence/faysal) |


### Current Progress

| Progress | Amount |
| --- | ---: |
| **My total assigned share** | **25.00%** |
| **Completed** | **19.50%** |
| **Remaining** | **5.50%** |
| **My assigned work completed** | **78%** |
| **My assigned work remaining** | **22%** |

**Remaining dependency flow:**  
**Large Nextcloud backup > Tanvi/Wazuh connection > encryption/data-loss simulation + Wazuh detection > manual restore from MinIO > final report > presentation**

---

## Planned tasks (Kanban board)

| # | Task | Status |
|---|---|---|
| 1 | Create restricted MinIO backup user and policy | Done |
| 2 | Verify production bucket access and isolation | Done |
| 3 | Verify Restic repository with restricted credentials | Done |
| 4 | Connect APP01 (VLAN 20) to BKP01 (VLAN 40) on TCP 9000 | Done |
| 5 | Fix BKP01 return route to APP01 | Done / persistent route saved |
| 6 | Verify APP01 small backup | Done |
| 7 | Check repository health after interrupted large backup | Done |
| 8 | Prepare full Nextcloud backup test | In progress |
| 9 | Connect BKP01 logs to Wazuh | Pending |

---

## Iek 10 task list

- [X] **Create restricted MinIO backup user**

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

- [X] **Verify production bucket access and isolation**

- **What I did:** Tested the restricted account against the production bucket, the old test bucket, and MinIO administration.

- **Why I need to do this:** I needed to prove that the account can do backup work but cannot access unrelated resources.

- **Problem and Solution:** The production bucket worked correctly. The old test bucket and admin commands returned `Access Denied`, which is the expected result.

- **Justification:** A security control should prove both alloId access and denied access.

- **Code used:**

```bash
mc ls backup-test/ag3-plains-pastoral-backups
mc ls backup-test/test-01-ag3-backups
mc admin user ls backup-test
```

**What this code does:** These commands test what the restricted account can and cannot access. The first should work, while the second and third should be denied.


<img width="2114" height="222" alt="image" src="https://github.com/user-attachments/assets/7a36602e-b3b5-4ac5-94cc-ac06f272a90d" />  

- **Screenshot:** Production bucket alloId; test bucket and admin command denied.

---

- [X] **Verify Restic with Restricted Credentials**

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

- **Screenshot:** Production repository `d1f8bc5e`, snapshot created, and `no errors Ire found`.

---

- [X] **Verify Production Backup Automation**

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

**What this code does:** The first command loads the backup settings from `.env`. The script then runs the backup job, the exit code confirms success or failure, and the final command verifies a snapshot was created.


<img width="1629" height="429" alt="image" src="https://github.com/user-attachments/assets/4d84ad77-1467-44f5-b131-bd8f217fc428" />  

- **Screenshot:** Script exit code `0` and production snapshots.

---

- [X] **Verify BKP01 VLAN 40 and APP01 connectivity**

- **What I did:** Confirmed BKP01 uses `10.20.40.10/24` on `enp0s8`, confirmed the VLAN 40 gateway, and tested APP01 connectivity.

- **Why I need to do this:** APP01 cannot push backups to BKP01 unless the VLAN and gateway configuration is correct.

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

- [X] **Test APP01 > BKP01 MinIO on TCP 9000**

- **What I did:** Confirmed MinIO was listening on TCP 9000 and tested the real service connection from APP01.

- **Why I need to do this:** Restic on APP01 sends backup data to MinIO on BKP01 using TCP 9000.

- **Problem and Solution:** The first TCP test timed out. Packet capture shoId APP01 SYN packets reaching BKP01, so the firewall path was working. The real problem was the BKP01 return route.

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

- [X] **Fix BKP01 return route to APP01**

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

- **Screenshot:** Wrong route before the fix and saved route `10.20.20.0/24 10.20.40.1`.

---

- [X] **Verify APP01 small backup**

- **What I did:** Checked the production repository from BKP01 and confirmed an APP01 snapshot exists.

- **Why I need to do this:** This proves that APP01 can successfully push backup data through pfSense to MinIO on BKP01.

- **Problem and Solution:** The APP01 snapshot was only a small test backup, not the full Nextcloud backup.

- **Justification:** The small backup proves the network, credentials, repository password, and basic Restic path are working.

- **Code used:**

```bash
restic snapshots --host app01
```

**What this code does:** This filters the Restic snapshot list so I can see only backups created by APP01.

- **Screenshot:** APP01 snapshot `e7d7787b` from `/home/shourab/restic-test`.

---

- [X] **Check stale lock and repository health**

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

- **Screenshot:** Lock information and final integrity check showing `8 / 8 snapshots` with no errors.

---

- [X] **Check BKP01 storage capacity**

- **What I did:** Checked MinIO bucket usage and available disk space.

- **Why I need to do this:** Shourab's Nextcloud data is hundreds of megabytes, so I needed to confirm BKP01 has enough storage.

- **Problem and Solution:** The production bucket currently uses only a small amount of space, while BKP01 has about 15 GB free. The bucket is not too small.

- **Justification:** This rules out storage capacity as the cause of the failed large backup.

- **Code used:**

```bash
mc du localminio/ag3-plains-pastoral-backups
df -h ~/minio-data
```

**What this code does:** The first command shows how much space the production bucket is using. The second shows how much disk space is available on BKP01.

- **Screenshot:** Bucket usage and disk showing approximately 15 GB available.

---

- [ ] **Complete full Nextcloud backup**

- **What I did:** Shourab started a real backup of Nextcloud application and data. The transfer progressed, but it did not finish with a completed production snapshot.

- **Why I need to do this:** The final system must protect real Nextcloud data, not only small test files.

- **Problem and Solution:** During the large transfer, MinIO reported `PutObject` lock timeouts. I also confirmed that MinIO was manually restarted during the testing period, which can interrupt active uploads. For the next test, MinIO will remain running, APP01 Restic will be updated, and S3 concurrency will be reduced.

- **Justification:** The small backup already proves the network and credentials work. The next test should focus on reliable sustained transfer.

- **Code used:**

On APP01:

```bash
sudo -E restic -o s3.connections=1 backup   /var/ncdata   --tag app01   --tag nextcloud   --tag large-test
```

On BKP01:

```bash
sudo journalctl -u minio -f
```

**What this code does:** This follows the MinIO service log live so I can immediately see errors while the large APP01 backup is running.

- **Screenshot:** Large Nextcloud backup progress and final successful snapshot when completed.

---

- [ ] **Connect backup logs to Wazuh**

- **What I did:** BKP01 already writes backup events to `/var/log/cyber-resilience/backup.json`.

- **Why I need to do this:** Tanvi's Wazuh server needs to detect successful and failed backups centrally.

- **Problem and Solution:** MON01 was not reachable during the previous test session, so the Wazuh agent integration is still pending.

- **Justification:** A backup failure must be visible to the monitoring system rather than remaining unnoticed.

- **Code used:**

```bash
tail -5 /var/log/cyber-resilience/backup.json
```

**What this code does:** This displays the latest five structured backup log entries that will later be collected by Wazuh.

- **Screenshot:** JSON backup event showing `status: success`.

---

## Evidence to collect this Iek

| Task | Status |
|---|---|
| Restricted `backup-administrator` user and policy | Done |
| Production bucket alloId with restricted account | Done |
| Old test bucket denied | Done |
| MinIO admin command denied | Done |
| Restic backup using restricted credentials | Done |
| Production repository integrity check | Done |
| BKP01 VLAN 40 configuration | Done |
| APP01 > BKP01 TCP 9000 connection | Done |
| MinIO health endpoint HTTP 200 | Done |
| Wrong return route identified and corrected | Done |
| Persistent VLAN 20 route saved | Done |
| Small APP01 backup snapshot | Done |
| Disk capacity verified | Done |
| Full Nextcloud production snapshot | Pending |
| Wazuh dashboard backup event | Pending |

---

## Carried over to Iek 11

- Complete the full Nextcloud backup from APP01.
- Verify the completed APP01 snapshot from BKP01.







# Iek 10

## Created a final bucket to back up real data
Navigate to the Project Folder: `cd ~/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5`  
Create a new and Final Bucket: `mc mb localminio/ag3-plains-pastoral-backups`  
Check List of Buckets: `mc ls localminio`    

<img width="1373" height="293" alt="image" src="https://github.com/user-attachments/assets/248a2a36-0678-488c-af22-3caef9e4a8ad" />  
<img width="1570" height="844" alt="image" src="https://github.com/user-attachments/assets/83263f99-18ab-4d88-8062-acbe3209377c" />  

<img width="2041" height="717" alt="image" src="https://github.com/user-attachments/assets/5ce5449d-42e6-4944-9e79-33c1e10a602b" />  


## Confirm the admin alias works and the production bucket exists
`mc ls localminio`
Check System is running: `systemctl is-active minio`
<img width="890" height="98" alt="image" src="https://github.com/user-attachments/assets/1f806ea8-ca2d-47f1-bf67-2b7198ed7b65" />



## Create the restricted policy file
<img width="1915" height="1079" alt="image" src="https://github.com/user-attachments/assets/bda7ff30-477b-4501-88cf-eb42ac760b5b" />

## Create the policy inside MinIO
`mc admin policy create localminio ag3-restic-backup ~/ag3-restic-policy.json`

Why I use it:  
mc admin policy create = creates a MinIO access policy.  
localminio = your working MinIO admin alias.  
ag3-restic-backup = the name I are giving this restricted policy.  
~/ag3-restic-policy.json = the permissions file you just created.  
<img width="1918" height="89" alt="image" src="https://github.com/user-attachments/assets/9967125f-fbf8-4773-a2da-521d4cce70b8" />




## Create the restricted MinIO user  

 
## Attach the restricted policy to the user  





<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/2cd3548c-7238-48bb-bb8f-c31be84572dc" />  
<img width="1917" height="1079" alt="image" src="https://github.com/user-attachments/assets/0cfdb68f-9dfd-47e3-bead-187dd4986a13" />  

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/2aec391c-d787-494e-be3f-732edc62f25b" />  
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/57e8b043-a8ab-4c61-8123-eea36c75da3e" />  
<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/07424d2b-9d1e-4433-a123-30397767f7b0" />  





## 
- Run a full restore test and verify recovered files.
- Measure recovery time against the project RTO.
- Schedule the production APP01 backup every 4 hours.
- Connect BKP01 JSON logs to MON01/Wazuh.
- Complete the final network-isolation test with Akib.
