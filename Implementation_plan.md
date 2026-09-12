# AG-3 Implementation Plan

## 1. Purpose

This document sets out how the AG-3 system is being implemented — what each component does, how they connect, what has been built, and what remains. The goal of the project is a **cyber-resilient IT infrastructure for a small agribusiness** that can survive a ransomware attack: when files are encrypted, the business detects the attack, keeps its backups beyond the attacker's reach, and restores the lost data from a clean copy.

---

## 2. The Team and Their Components

| Component | System | Owner | Role in the system |
|---|---|---|---|
| Firewall / Network | pfSense + Cisco Catalyst 3560-CX | **Akib** | Segments the network into VLANs and controls every path between them |
| Application server | Nextcloud (APP01) | **Shourab** | Holds the business's working data; identity and access management |
| Backup & Recovery | Restic + MinIO (BKP01) | **Faysal** | Encrypted, automated backups in an isolated zone; recovery |
| Monitoring | Wazuh (MON01) | **Tanvi** | Watches activity, detects attacks, raises alerts |

---

## 3. Network Architecture

The network is divided into five VLANs on a managed Cisco switch, with pfSense routing and filtering all traffic between them. Devices on one VLAN cannot reach another unless the firewall explicitly permits it — this separation is what keeps the backups safe from a compromised office machine.

| VLAN | Name | Subnet | Key host | Gateway |
|---|---|---|---|---|
| 10 | Office | 10.20.10.0/24 | Staff PCs (users) | 10.20.10.1 |
| 20 | Server | 10.20.20.0/24 | APP01 — Nextcloud (10.20.20.10) | 10.20.20.1 |
| 30 | Security | 10.20.30.0/24 | MON01 — Wazuh (10.20.30.10) | 10.20.30.1 |
| 40 | Backup | 10.20.40.0/24 | BKP01 — MinIO (10.20.40.10) | 10.20.40.1 |
| 99 | Management | 10.20.99.0/24 | Administrative access | 10.20.99.1 |

The switch trunk to pfSense is carried on an 802.1Q trunk port (Gi0/13). Where the home-lab switch was unmanaged, VLAN separation was achieved by host-level VLAN tagging so the design could still be tested.

---

## 4. How the System Works

### 4.1 Normal operation

1. **Users work in Nextcloud.** Staff on the Office VLAN access the Nextcloud portal over HTTPS and read and write the business's files, organised into role-based Team Folders (Finance, Operations, Sales, Management, IT, Backup, Company Shared).
2. **Data is backed up every four hours.** On BKP01, an automated job runs every four hours: Restic reads the Nextcloud data, encrypts and deduplicates it, and writes a point-in-time snapshot into MinIO on the isolated Backup VLAN.
3. **Every backup is verified.** An integrity check runs immediately after each backup, confirming the snapshot is complete and restorable.
4. **Status goes to monitoring.** Each backup attempt writes a JSON event that the Wazuh agent forwards to MON01 — a low-severity alert on success, a higher-severity one on failure.
5. **Wazuh watches everything.** It monitors authentication, file integrity and network activity across the VLANs, building a baseline of normal behaviour.

### 4.2 The resilience flow (target end state)

```
Users → input & use data → stored in Nextcloud (APP01)
                                   ↓  every 4 hours
                          encrypted backup → MinIO (BKP01, isolated VLAN 40)
                                   ↓
                    all activity monitored by Wazuh (MON01)
                                   ↓
              ⚡ ransomware attack encrypts Nextcloud data
                                   ↓
                Wazuh detects mass encryption → raises alert
                                   ↓
        restore encrypted files from the last clean MinIO snapshot
                                   ↓
   backups survive because MinIO is isolated from the rest of the network
```

---

## 5. The Ransomware Scenario and the Recovery Guarantee

An office user is compromised; ransomware encrypts their PC, then spreads to Nextcloud through the path the user legitimately uses. It then attempts to reach the backups — and fails, because the Backup VLAN is unreachable from the office network (firewall) and a normal account is denied access to the backup store (credentials).

**What is guaranteed:** every file already backed up is recovered completely and verified by hash.

**The limitation (RPO):** because backups run every four hours, data created between the last backup and the attack is lost. For example, if the last backup ran at 2:00 AM and the attack strikes at 3:30 AM, everything up to 2:00 AM is fully recovered and the 90 minutes after it is not. This is the Recovery Point Objective — a maximum of four hours of potential loss — and it is a deliberate, documented trade-off, not a fault.

---

## 6. Implementation Status by Component

### 6.1 Backup & Recovery — Faysal (this workstream)

| Capability | Status | Evidence |
|---|---|---|
| Restic + MinIO installed, encrypted repository | Done | evidence/faysal/Week 5 |
| Backup & restore proven end-to-end | Done | testing/backup-restore-test-results.md |
| Credential isolation (office account denied) | Done | evidence/faysal/Week-6 (#43) |
| Automated 4-hourly backup + integrity check | Done | scripts/backup.sh (#54) |
| Deliberate-failure test | Done | (#55) |
| Retention policy | Done | config/retention-policy.md (#56) |
| MinIO auto-start on boot (systemd) | Done | (#54) |
| Backup status in Wazuh JSON format | Done | scripts/backup.sh (#57) |
| Backup server on isolated Backup VLAN 40 | Done | evidence/faysal/Week-7 (#61) |
| Wazuh agent connected to MON01 | In progress | #57 |
| Back up real Nextcloud data | In progress | #63 — needs VLAN 20→40 path |
| Network isolation test (office blocked) | Planned | #44 |
| Automated restore trigger | Planned | design goal |

### 6.2 Network & Firewall — Akib

| Capability | Status |
|---|---|
| Cisco switch configured; five project VLANs created | Done |
| Access ports assigned; Gi0/13 trunk to pfSense | Done |
| pfSense VLAN interfaces + gateway addressing | Done |
| Internet connectivity via pfSense verified | Done |
| BKP01 reaches its gateway 10.20.40.1 | Done |
| Inter-VLAN firewall rules (allow/deny paths) | In progress |
| Detailed head-office design (Office, Server, Security, Backup, Guest) | Done |

### 6.3 Application & Identity — Shourab

| Capability | Status |
|---|---|
| Nextcloud (APP01) configured and reachable | Done |
| Role-based user groups (Finance, Ops, Sales, IT, Backup, etc.) | Done |
| Six centrally-managed Team Folders with quotas | Done |
| Folder access rules per group | Done |
| Multi-Factor Authentication on admin account | Done |
| Office PCs can access Nextcloud via pfSense | Done |

### 6.4 Monitoring — Tanvi

| Capability | Status |
|---|---|
| Wazuh manager + dashboard operational | Done |
| Agent log collection and alerting | Done |
| Failed-login / brute-force detection (SSH) | Done |
| File Integrity Monitoring (create/change/delete) | Done |
| Ingest backup JSON events from BKP01 | In progress |
| Ransomware (mass-encryption) detection rules | Planned |

---

## 7. Current Integration Blockers

| Blocker | Detail | Owner(s) | Target |
|---|---|---|---|
| Nextcloud → MinIO backup path | BKP01 can reach APP01 (VLAN 40→20), but the return path (VLAN 20→40) is not yet open, so Restic cannot pull data | Faysal + Akib | Week 9 |
| Wazuh agent connection | BKP01 can reach MON01 but the Wazuh service is not yet accepting the agent | Faysal + Tanvi | Week 9 |
| Ransomware detection rules | Detection of mass-encryption behaviour not yet configured | Tanvi | Week 10 |

These are configuration issues on a working network, not fundamental design problems — connectivity between the VLANs has been proven.

---

## 8. Weekly Plan to Completion

| Week | Focus |
|---|---|
| 1–7 | Foundation and automation (complete). Backup workstream: install, encrypt, automate, schedule, isolate — all delivered ahead of the Week 9 target (OBJ-05). |
| 8 | VLAN network set up and all machines connected. Inter-VLAN connectivity proven. |
| 9 | Integrate Wazuh + MinIO with Nextcloud; simulate the backup flow from Nextcloud to MinIO with Wazuh monitoring all traffic; begin researching ransomware simulation. |
| 10 | With integration working, back up real Nextcloud data; prepare a safe, mentor-approved data-loss simulation. |
| 11 | Run the full simulation: ransomware encrypts Nextcloud data → Wazuh raises an alert → encrypted files are auto-restored from MinIO → confirm the backup zone stayed isolated. Finalise that the system meets the project goal. |
| 12 | Final GitHub updates and contribution to the Final Report (Assessment 3) and presentation (Assessment 4). |

The team keeps the GitHub repository updated every week.

---

## 9. Success Criteria

| Objective | Target | How it is proven |
|---|---|---|
| Automated encrypted backup (OBJ-05) | Every 4 hours, by Week 9 | restic snapshots over several days — achieved early |
| Tested recovery within RTO (OBJ-06) | RTO 2h priority / 4h full, by Week 11 | Timed restore during the simulation |
| Recovery point (RPO) | Max 4 hours data loss | Backup schedule; worked example in Section 5 |
| Backups survive the attack | 100% of backed-up data recovered | Isolation tests + verified restore |
| Attack is detected | Alert on mass encryption | Wazuh detection during the simulation |

---

## 10. Ethical and Professional Considerations

- **Safe simulation, not real malware.** The ransomware test reproduces the *effect* of an attack (encrypting or deleting files in a designated test area) using a controlled script. No real or self-spreading malware is used, and the mentor approves the plan and scope in writing beforehand.
- **Data protection.** Real credentials are never committed to GitHub (excluded via `.gitignore`); test accounts and invalid usernames are used for security testing rather than real staff accounts.
- **Least privilege.** Access is granted by role, and the backup store denies ordinary office accounts by design.
- **Honest reporting.** The system's limitation (the RPO gap) is documented clearly so the business would understand exactly what protection it has.

---
