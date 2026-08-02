# AG-3 — Cyber Resilience for an Agribusiness Back Office

**COIT20265 Networks and Information Security Project (HT2, 2026) — Group PG5**

A representative back-office environment for a small agribusiness ("Plains Pastoral Co."), built to demonstrate practical, tested cyber resilience: enforced MFA/identity, network segmentation, security monitoring, and automated encrypted backup with a live, timed recovery from a simulated ransomware event.

## Team

| Member | Student ID | Workstream |
|---|---|---|
| Shourab | 12298592 | Identity & MFA — Nextcloud accounts, roles, TOTP MFA |
| Akib | 12304711 | Network architecture — pfSense, VLANs, firewall rules |
| Tanvi | 12297656 | Monitoring & hardening — Wazuh, OS hardening baseline |
| Faysal | 12281612 | Backup & recovery — Restic/MinIO, automation, timed recovery |

**Weekly meeting:** Tuesday 4:30–4:45 PM

## Repository structure

```
/README.md      — this file
/docs           — design docs, IP/VLAN plan, security policy, runbooks, test plans
/configs        — pfSense, Nextcloud, Wazuh, Restic/MinIO config exports (secrets removed)
/topologies     — architecture diagrams and virtualisation project files
/scripts        — automation: backup, verification, simulation, rebuild (Bash/Python/PowerShell)
/testing        — acceptance-test plans, results, screenshots, RTO/RPO measurements
/evidence       — per-member evidence folders (see Teamwork Framework)
/AI-log.md      — running, dated record of AI use across the team
```

## Environment overview

| Component | Role |
|---|---|
| Nextcloud | Business application — user accounts, role-based folders, MFA |
| pfSense | Perimeter firewall and inter-VLAN routing |
| VLANs | Office / Server / Security / Backup / Management segmentation |
| Wazuh | Centralised monitoring — auth events, file-integrity, firewall logs |
| Restic + MinIO | Encrypted backup client and isolated backup target |

See `/topologies` for the full architecture diagram and IP/VLAN plan.

## Getting started

1. Clone the repo:
   ```
   git clone https://github.com/<org>/AG3-capstone.git
   cd AG3-capstone
   ```
2. Review `/docs/architecture.md` for the network layout and VM/resource requirements.
3. Bring up the environment in your chosen substrate (virtualised lab, e.g. GNS3/VirtualBox/Proxmox — see `/docs` for the confirmed choice).
4. Apply configs from `/configs` in this order: network (pfSense/VLANs) → identity (Nextcloud) → monitoring (Wazuh) → backup (Restic/MinIO).
5. Run acceptance tests from `/testing` to confirm each component against its success criteria.

*(Exact commands/scripts will be added to `/scripts` and linked here as each workstream is built.)*

## Key documents

- Project Proposal — `/docs/AG3_Project_Proposal.docx`
- Risk register — `/docs/risk-register.md`
- Individual Research & Evidence Responsibilities — `/docs/evidence-responsibilities.pdf`
- Test plan & acceptance criteria — `/testing/test-plan.md`
- Recovery runbook — `/docs/recovery-runbook.md`

## Success criteria (summary)

- **RPO:** ≤ 4 hours of data loss
- **RTO — priority files:** ≤ 2 hours
- **RTO — full portal:** ≤ 4 hours
- Live, timed recovery from a simulated ransomware event, demonstrated end-to-end

## Team workflow

This repo is one of three tools used together (GitHub Projects/Kanban board + Microsoft Teams are the other two) — see the Teamwork Framework for full detail. In short:

- **Commits:** conventional prefixes (`feat:` / `fix:` / `docs:` / `test:`), small and frequent, not batched near deadlines
- **Kanban:** every card has one owner, one label, and is linked to the commit/PR that completed it
- **AI use:** logged in `AI-log.md` as it happens, not retrospectively

## Status

🔧 Environment build in progress — see the Kanban board for current task status.

---
*Private repository — coursework submission for COIT20265, CQUniversity. Not for public distribution.*
