# Week 6 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, automation, and recovery  
**Week 6 goal:** Complete the isolation testing carried over from Week 5, remove the session-variable friction that caused repeated errors, and prepare the groundwork for automated scheduled backups in Week 7.  

## Planned tasks (Kanban board)

The screenshot below shows my Week 6 backup cards created and assigned on the team Kanban board:

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/2e417ee6-32b9-4528-be91-2d492759ed36" />


## Week 6 task list

- [ ] **Progress Report 1 (Assessment 2)**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

---

- [ ] **Installing the tool: MinIO Client (mc)**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

---

- [ ] **Create restricted office-user and test denial**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

_Note: In this test an "Access Denied" error is a **PASS**, not a failure — it proves the credential isolation is working as designed._

---

- [ ] **Coordinate network isolation test with Akib**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

_Dependency: This task is blocked by Akib's VLAN and firewall configuration (card #37). Questions raised cover the backup VLAN ID/IP range, deny-by-default rules on ports 9000/9001, permitted hosts, and a testing date._

---

- [ ] **Create environment config file**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

_Purpose: Two failed commands in Week 5 were caused by retyping long environment-variable names. Loading them from a single file removes that whole class of error and is a prerequisite for reliable automation in Week 7. The file is excluded from version control via `.gitignore`._

---

- [ ] **Research backup scheduling approach**

- What I did: 

- Issues faced and fixed: 

- Outcome: 

- What I learned: 

_Scope note: Planning and justification only this week — the automation is deployed in Week 7._

---

## Evidence to collect this week
| Tasks | Status |  
|---|---|  
| Progress Report 1 submitted | |  
| Screenshot of `mc` client installed and connected | |  
| Screenshot of office-user denied via `mc` | |  
| Screenshot of office-user denied via Restic | |  
| Network isolation test result (or documented dependency) | |  
| Config file created and `.gitignore` entry added | |  
| Scheduling approach documented with justification | |  
| All committed to this folder with dated filenames | |  
| Plan for Week 7 | |  

---

## Carried over from Week 5
- **Prove MinIO backup isolation** — deferred because MinIO Community Edition's console lacks user management (requires `mc`), and the network-isolation half depends on Akib's VLAN configuration.

## Dependencies
| Item | Depends on | Status |
|---|---|---|
| Network isolation test | Akib — VLAN and firewall rules (card #37) | Pending |
| Backup event monitoring (Week 7+) | Tanvi — Wazuh setup | Not yet required |
| Priority data definition (Week 9+) | Shourab — Nextcloud data | Not yet required |
