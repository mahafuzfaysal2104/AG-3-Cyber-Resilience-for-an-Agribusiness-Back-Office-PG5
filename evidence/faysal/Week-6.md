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

MinIO's web console has no user-management screen `mc` is the only way to create a restricted, non-admin account. This step exists to serve FR-08 in the Project Proposal ("stop normal office users from reaching the backup repository"): without mc, there's no way to create the low-privilege account #43 needs to actually prove that isolation, rather than just assume it.

- What I did: Installed mc, connected it to my MinIO server, confirmed it can list my backup bucket.

- Outcome: `mc ls localminio` returned the bucket with a timestamp. Card #42 complete.

 

<img width="792" height="829" alt="image" src="https://github.com/user-attachments/assets/04e52b2c-2de1-42f3-8035-adfb1238bc95" />  

<img width="1232" height="162" alt="image" src="https://github.com/user-attachments/assets/158e3cf8-d86e-4ab5-838e-d3d8953be6c9" />






---

- [ ] **Create restricted office-user and test denial**

- What I did: Created a restricted, non-admin MinIO user (office-user1) with no policy attached, then tried accessing the backup bucket using that account's own login.

- Outcome: mc ls officeuser/test-01-ag3-backups returned Access Denied. The account authenticated successfully but couldn't read the bucket. Card #43 complete.

- What I learned: A valid login and permission to access data are two different things. MinIO denies by default until a policy is granted, and this test proves that default holds even for a real, working account.

<img width="970" height="208" alt="image" src="https://github.com/user-attachments/assets/74456bee-f571-47b9-946b-48851493e97a" />

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
| Progress Report 1 submitted | Done |  
| Screenshot of `mc` client installed and connected | Done |  
| Screenshot of office-user denied via `mc` | Done |  
| Screenshot of office-user denied via Restic | Done |  
| Network isolation test result (or documented dependency) | In Progress |  
| Config file created and `.gitignore` entry added | Pending |  
| Scheduling approach documented with justification | Pending |  
| All committed to this folder with dated filenames | Pending |  
| Plan for Week 7 | Need  to Finish by 18/08/2026 |  

---

## Carried over from Week 5
- **Prove MinIO backup isolation** — deferred because MinIO Community Edition's console lacks user management (requires `mc`), and the network-isolation half depends on Akib's VLAN configuration.

## Dependencies
| Item | Depends on | Status |
|---|---|---|
| Network isolation test | Akib — VLAN and firewall rules (card #37) | Pending |
| Backup event monitoring (Week 7+) | Tanvi — Wazuh setup | Not yet required |
| Priority data definition (Week 9+) | Shourab — Nextcloud data | Not yet required |
