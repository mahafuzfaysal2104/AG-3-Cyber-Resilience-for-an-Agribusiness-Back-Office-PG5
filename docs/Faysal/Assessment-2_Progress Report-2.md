# COIT20265 — Assessment 2
## Progress Report 2
### AG-3: Cyber Resilience for an Agribusiness Back Office

**Prepared by:** Md Mahafuz Faysal  
**Student ID:** 12281612  
**Group:** PG5  
**Workstream:** Backup, Recovery and Integration  
**Reporting period:** Weeks 7–9  
**Repository:** [https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5](https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5)

---

# 1. Individual Role and Progress

My assigned responsibility in the AG-3 project is the **Backup, Recovery and Integration** workstream. My technical responsibilities include operating the Restic and MinIO backup environment, automating encrypted backups, verifying backup integrity, supporting network isolation, integrating backup events with Wazuh monitoring, and later leading the timed recovery and RTO/RPO testing.

Progress Report 1 demonstrated the backup foundation: I installed Restic and MinIO, created an encrypted repository, backed up synthetic agribusiness data, and successfully restored the files after removing the source data.

During Weeks 7–9, my focus shifted from manually proving backup and recovery worked to making the process **automatic, repeatable, monitored, and ready for integration** with other team members' systems.

The main verified achievement during this period was the completion of the backup automation work in Week 7. This delivered the project's automated four-hour backup objective ahead of the planned Week 9 target.

---

# 2. Work Completed During the Reporting Period

## 2.1 Environment Configuration

During Weeks 5 and 6, several command failures were caused by manually re-entering long environment-variable names and credentials. That approach was not suitable for an unattended backup system.

I therefore created `config/.env` containing the required MinIO endpoint and credentials, Restic repository information, repository password and backup source. I secured the file with:

```bash
chmod 600 config/.env
```

and added it to `.gitignore` so that the real credentials are not committed to GitHub.

After sourcing the configuration file, `restic snapshots` opened the repository without requiring manual environment exports. This reduced typing errors and created the configuration base required by the automated backup script.

### GitHub evidence

<img width="850" alt="Environment configuration evidence" src="https://github.com/user-attachments/assets/9033f594-9b03-45a0-a8bd-8eea3fab8ed8" />

*Figure 1. Week 7 environment/configuration evidence from the project repository.*

---

## 2.2 Automated Backup Script

I created `scripts/backup.sh` to automate the backup process. The script loads the configuration, runs the Restic backup, performs `restic check`, records the result and returns an appropriate exit code.

The successful test produced **exit code 0**, created snapshot `48b9e2fc`, and completed the repository integrity check without errors. The small test run took approximately two seconds.

This task showed me that automation is more than running a command automatically. The process must also verify the result and create evidence that the expected backup activity actually occurred.

### GitHub evidence

<img width="850" alt="Automated backup script evidence" src="https://github.com/user-attachments/assets/497cb401-f5c3-4837-a3b8-a3dc6cd4a521" />

*Figure 2. Successful automated backup / Restic verification evidence.*

---

## 2.3 Four-Hour Backup Schedule

To support the project's **RPO of four hours**, I configured the backup script to run automatically every four hours using cron:

```text
0 */4 * * *
```

This runs the backup six times per day at 00:00, 04:00, 08:00, 12:00, 16:00 and 20:00.

I also configured MinIO to start automatically after a reboot so scheduled backups can continue without manual intervention. After testing, MinIO restarted successfully and the cron schedule remained active.

### GitHub evidence

<img width="850" alt="Cron and MinIO service evidence" src="https://github.com/user-attachments/assets/c35318af-ff07-4ad1-a1a1-e6ae084fbb57" />

*Figure 3. Week 7 scheduling / service persistence evidence.*

---

## 2.4 Retention Policy

I kept the same retention policy used in the previous project document. The purpose of this policy is to control repository growth while preserving useful restore points. The backup frequency remains **every four hours**; the retention policy only determines which older snapshots are kept when cleanup is performed.

The policy is:

```bash
restic forget \
  --keep-hourly 6 \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6
```

Before applying any deletion, I first used the same policy with `--dry-run` to check which snapshots would be removed. After reviewing the output, I applied the policy with `--prune` and then ran `restic check` to verify the repository remained healthy.

In the Week 7 test, the repository was reduced from six snapshots to three. The removed snapshots were closely spaced test backups, 513 bytes were reclaimed, and `restic check` passed after pruning.

The four-hour cron schedule remains unchanged:

```text
0 */4 * * *
```

This means a new backup is still scheduled every four hours to support the project's **RPO target of no more than four hours**.

---

## 2.5 Deliberate Backup Failure Test

I deliberately tested the failure path rather than demonstrating successful backups only.

Before the test, I copied the working configuration as a safety measure. I then temporarily replaced the Restic password with an invalid value and ran the automated script.

The script exited with **code 1** and generated a failure event. I restored the correct configuration and ran the script again, which returned exit code 0 and a success event.

This was important because a backup that fails silently can create false confidence. The system must make failures visible.

### GitHub evidence

<img width="850" alt="Deliberate backup failure evidence" src="https://github.com/user-attachments/assets/ab3d13d9-f9a8-44bf-8046-316ff375f63e" />

*Figure 4. Deliberate failure testing and recovery evidence.*

---

## 2.6 Wazuh-Compatible Backup Logging

I began integration with Tanvi's Wazuh monitoring workstream.

After agreeing on the required log structure, I changed `backup.sh` so that it writes newline-delimited JSON events to:

```text
/var/log/cyber-resilience/backup.json
```

The events include information such as:

- Timestamp
- Event type
- Backup status
- Job name
- Hostname
- Source
- Destination
- Duration
- Message

A successful backup creates:

```json
"status":"success"
```

and a deliberate failure creates:

```json
"status":"failure"
```

My side of the structured logging work was completed. However, the backup VM still required a Wazuh agent and working connectivity to Tanvi's monitoring server before the events could be confirmed in the Wazuh dashboard.

For this reason, I do **not** claim that Wazuh dashboard integration was complete at this stage.

---

## 2.7 Backup VLAN 40

I moved the backup VM onto the project's Backup VLAN 40.

The verified configuration was:

| Component | Address |
|---|---|
| Backup server (BKP01) | `10.20.40.10/24` |
| Gateway | `10.20.40.1` |

The final gateway test returned **0% packet loss**, confirming that my backup server was correctly connected to its own VLAN and pfSense gateway.

The VM retained the NAT adapter for Internet access and used a second bridged adapter for the physical project network.

### GitHub evidence

<img width="850" alt="Backup VLAN 40 gateway evidence" src="https://github.com/user-attachments/assets/3c71690b-c44c-474e-9a2e-5bf56d63e5ca" />

*Figure 5. BKP01 configured on Backup VLAN 40 and gateway connectivity verified.*

---

# 3. Integration Challenges and Reflection

The main technical blocker after Week 7 was **inter-VLAN connectivity**.

Although BKP01 could reach its own gateway at `10.20.40.1`, I could not reliably reach:

- Shourab's Nextcloud server — `10.20.20.10`
- Tanvi's Wazuh server — `10.20.30.10`

during the Week 7 lab session.

This prevented me from honestly marking the following tasks as complete:

1. Wazuh agent/dashboard integration;
2. backup of actual Nextcloud data;
3. the complete network-isolation test with Akib.

One useful troubleshooting result came from testing TCP rather than relying only on ping. A test against `10.20.20.10` on TCP port 22 returned **Connection refused** instead of a timeout. This indicated that something responded at the address and demonstrated that ICMP/ping alone was not sufficient for diagnosing the segmented network.

This stage taught me that individual technical tasks and integration tasks are different. My backup automation could be completed independently, but end-to-end validation depends on the network, application and monitoring workstreams being available at the same time.

I also improved the way I report problems to teammates. Instead of saying only that "the network is not working", I documented the exact source and destination addresses, the test command, the result and the dependency. This gives the network owner useful evidence for troubleshooting.

---

# 4. Outstanding Integration Work

The following items were still outstanding in the available Week 8 evidence and are therefore not reported as completed.

## #58 — Refine the MinIO credential-isolation test

The Week 6 test proved that an unauthorised account could be denied access. The stronger test is to give the account legitimate access to a normal bucket while specifically denying access to the backup bucket.

Expected result:

```text
ordinary permitted bucket → allowed
test-01-ag3-backups       → Access Denied
```

---

## #59 — Document backup network requirements

The required communication rules need to be recorded for the network workstream.

The planned requirements are:

- APP01 / Server VLAN → BKP01 TCP 9000: allowed
- Management VLAN → BKP01 TCP 9001: allowed where required
- Office VLAN → BKP01: denied

---

## #62 — Re-verify through the VLAN address

The Restic/MinIO configuration needs to be re-tested after changing the endpoint from localhost to:

```text
10.20.40.10
```

The final verification should include:

```bash
restic snapshots
./scripts/backup.sh
restic check
restic restore ...
```

---

## #57 — Complete Wazuh integration

The JSON output is ready, but the backup VM needs its own Wazuh agent connected to:

```text
MON01 — 10.20.30.10
```

A successful and deliberately failed backup should both appear in the Wazuh dashboard before this task is marked complete.

---

## #63 — Back up actual Nextcloud data

The mechanism has been demonstrated using synthetic files. The integrated test requires actual Nextcloud content once:

- APP01 is reachable;
- Shourab confirms the correct data path;
- read access is arranged; and
- test data exists in Nextcloud.

---

## #44 — Network-isolation test with Akib

The final isolation test needs to demonstrate both an allowed and denied path.

Expected:

```text
APP01 → BKP01:9000     ALLOWED
Office VLAN → BKP01    BLOCKED
```

Testing both paths is necessary because a failed connection alone does not prove a firewall rule; it could also mean that the destination server is offline.

---

# 5. Remaining Project Plan

The next phase is verification rather than adding unnecessary features.

## Week 9 — Verify

The main checks are:

- Confirm scheduled four-hour backups are occurring;
- Run `restic check`;
- Complete Wazuh connectivity;
- Back up Nextcloud data;
- Restore through the network address;
- Verify network isolation;
- Prepare the safe ransomware-loss simulation.

## Week 10 — Safe simulation

The project will simulate the **effect** of ransomware, not deploy real ransomware.

The test will use a designated dummy/test directory only.

Safety requirements include:

- Verified clean snapshot before testing;
- Mentor approval;
- Team notification;
- No execution against the MinIO repository;
- No self-spreading code;
- No destructive malware.

## Week 11 — Timed recovery

The timed recovery test will:

1. Identify the latest clean snapshot;
2. Start the recovery timer;
3. Restore with Restic;
4. Stop the timer;
5. Compare file count;
6. Compare SHA-256 hashes;
7. Record measured RTO and RPO.

### Project targets

| Metric | Target |
|---|---|
| RPO | ≤ 4 hours |
| RTO — priority files | ≤ 2 hours |
| RTO — full portal | ≤ 4 hours |

---

# 6. Professional Engagement and Learning

I continued to maintain evidence through GitHub, project documentation and Kanban tasks rather than relying on end-of-project statements.

The work during this period improved my understanding of:

- Bash scripting;
- Scheduled jobs;
- Service dependencies;
- Restic snapshot management;
- Failure handling;
- JSON security-event logging;
- VLAN addressing;
- Integration dependencies.

I also continued to verify guidance against the live environment instead of assuming instructions were correct. This was important because practical system behaviour sometimes differed from the initial guidance I received.

---

# 7. Conclusion

The main progress since Progress Report 1 is that the backup environment moved from a manual proof of concept to an **automated and testable backup service**.

The verified work includes:

- Secured environment configuration;
- Automated `backup.sh`;
- Four-hour cron schedule;
- MinIO automatic startup;
- Successful backup and integrity checking;
- Deliberate failure detection;
- Retention testing;
- Wazuh-compatible JSON events;
- BKP01 configuration on Backup VLAN 40.

The four-hour schedule remains central to the design because it supports the agreed RPO.

The available evidence does **not yet support claiming** that the full Nextcloud-to-MinIO path, Wazuh dashboard integration or Office-VLAN network-isolation test has been completed. These remain the immediate integration priorities before the safe ransomware-loss simulation and the final timed recovery.

A reliable backup system is not proven simply by having backup files. It is proven when backups run automatically, failures are visible, access is controlled, restoration works, and the result can be measured against defined RTO and RPO targets.

---

# Appendix A — Evidence References

## Key repository evidence

- `evidence/faysal/Week-7-updated.md`
- `evidence/faysal/Week-7-short.md`
- `evidence/faysal/Week-8-updated.md`
- `scripts/backup.sh`
- `config/retention-policy.md`
- `/var/log/cyber-resilience/backup.json` — runtime evidence, not committed with credentials
- GitHub Kanban cards #44, #45, #53, #54, #55, #56, #57, #58, #59, #61, #62, #63

## Repository

https://github.com/mahafuzfaysal2104/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5
