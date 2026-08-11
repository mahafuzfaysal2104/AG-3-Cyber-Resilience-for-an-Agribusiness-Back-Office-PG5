# Week 5 — Backup Workstream Progress (Faysal)

**Workstream:** Restic/MinIO backup, automation, and recovery  
**Week 5 goal:** Get the backup foundation running — install the tools, create a first encrypted repository in MinIO, take a first backup of synthetic test data, and confirm I can list and restore snapshots.  

## Planned tasks (Kanban board)

The screenshot below shows my Week 5 backup cards created and assigned on the team Kanban board:

![Week 5 Kanban board](01week5-kanban-todo-list.png)
_N.B. A lot of changes happen after even taking this screenshot. This screenshot was taken just after initial planning._

## Week 5 task list

- [X] **Environment Setup in Oracle VirtualBox**

- What I did: Set up the backup environment from scratch. Created a VM in VirtualBox (AG3-Backup-Server, 4 GB RAM, 2 CPUs, 30 GB disk, NAT network), installed Ubuntu Desktop 26.04 with an interactive install, chose no disk encryption and the default ext4 filesystem, and created a dedicated user account. This VM became the platform for installing Restic and MinIO.

- Issues faced and fixed: Unattended install was ticked by default; this would auto-configure everything and cause problems. Fixed by unticking "Proceed with Unattended Installation" so I could install manually and keep control. Confused by encryption/filesystem options. Unsure whether to encrypt or pick a special filesystem. Decided on "No encryption" and default ext4, since Restic handles backup encryption and MinIO handles isolation, so full-disk encryption wasn't needed for a lab VM.
Accidentally shut the VM off mid-work; worried I'd lost progress. Learned that everything installed stays on the VM disk; only the running MinIO process and session variables needed restarting.

- Outcome: A working Ubuntu VM running in VirtualBox, ready to host the backup tools, with resources sized appropriately and network set to NAT (overlay VPN planned later for team access).

- What I learned: A VM's virtual disk is fully isolated from the host, so "erase disk" during install is safe; unattended install should be avoided when learning; the environment choice (local NAT now, overlay later) supports making the build team-accessible without rebuilding.

![Environment Setup in Oracle VirtualBox](02week5-environment-set-up-on-oracle-virtual-box.png)
![Ubuntu Setup in Oracle VirtualBox](03week5-environment-set-up-on-oracle-virtual-box-ubuntu.png)

---


- [X] **Installing the tool: Restic**
- What I did: Installed Restic (the backup engine) on the Ubuntu VM. Created the VM in VirtualBox, installed Ubuntu Desktop, opened the terminal, updated the package list with `sudo apt update`, installed Restic with `sudo apt install restic -y`, and confirmed it worked by running restic version, which returned a version number: **0.18.1**

- Issues faced and fixed: New to the Linux terminal, password entry shows nothing on screen when typing sudo commands, which was confusing at first. Learned this is normal Linux behaviour (hidden input) and continued. Chose the right setup during VM creation, avoided the "unattended installation" option and disk encryption, so I could install manually and keep the lab VM simple. Selected "No encryption" and the default ext4 filesystem.

- Outcome: Restic installed successfully and restic version returned a valid version number, confirming the backup engine was ready to use.

- What I learned: sudo runs commands with admin rights and hides password input; apt is Ubuntu's package installer; the VM's virtual disk is fully isolated from the real laptop, so "erase disk" during install was safe.

![Downloaded and Installed Restic in Oracle VirtualBox](04week5-download-and-version-check-restic-ubuntu.png)  
![whoami && hostname && Restic version check in Oracle VirtualBox](05week5-download-and-version-check-restic-ubuntu.png)   

---

- [X] **Installing the tool: MinIO**

- What I did: Installed the MinIO server (the isolated backup storage) on the Ubuntu VM. Downloaded the MinIO binary with wget, made it executable with `chmod +x`, moved it to /usr/local/bin/, created a data folder (~/minio-data), set the admin credentials (user **PG5**, password **PG520265**), and started the server. Then opened the console in Firefox at localhost:9001, logged in successfully, and created the bucket **test-01-ag3-backups**.

- Issues faced and fixed: Environment variables are session-only; the `MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD` exports clear on restart, so MinIO has to be relaunched with them each session. Managed by re-running the export and start commands after any restart. MinIO runs in the foreground, occupying the terminal while running, so closing that terminal stops the server. Handled by leaving it running in its own terminal and opening a second terminal for other commands.

- Outcome: MinIO server started successfully (API on port 9000, console on 9001), the console loaded in the browser, login worked, and the backup bucket was created and ready to receive the encrypted Restic repository.

- What I learned: MinIO's API port (9000) and console port (9001) are different and used for different purposes; the server must stay running in its own terminal; credentials set at startup become the console login.

![Installing and Setting up MinIO in Oracle VirtualBox](06week5-download-minio-ubuntu.png)   
![Setting Up the Environment of MinIO in Oracle VirtualBox](07week5-setting-up-minio-ubuntu.png)  
![MinIO_Local Host Login](08week5-MinIo-local-host-login-ubuntu.png)  
![MinIO Dashboard in Local Server](08.2-week5-MinIo-local-dashboard-login-ubuntu.png)   

---

- [X] **Initialize encrypted Restic repository in MinIO**

- What I did: I connected Restic to MinIO and created an encrypted backup repository. Started MinIO, created the bucket **test-01-ag3-backups**, set the connection variables (access key, secret key, repository path, password), ran restic init, and verified with restic snapshots.

- Issues faced and fixed: Shut the VM off mid-task; on restart, MinIO and my environment variables were gone and fixed by restarting the VM, relaunching MinIO, and re-entering the exports. No data lost (MinIO stores to disk).
"Secret is empty" error typo: wrote `AWS_SECRET_ACCESS_KEY_ID` instead of `AWS_SECRET_ACCESS_KEY`. Fixed by correcting the variable name.
Password not set typo: wrote `RESTIC_PASSWOR` (missing D). Fixed by correcting to `RESTIC_PASSWORD`.
- Outcome: After fixing the typos, restic init succeeded: "Created restic repository 046d89d603" and the repository opened cleanly. The encrypted repository is now live and ready for backups.
- What I learned: Environment variables clear on restart (must re-set each session or save to a file); exact variable names matter; the repository password is critical and irrecoverable if lost.
<img width="1292" height="814" alt="image" src="https://github.com/user-attachments/assets/3e6a385f-523e-46d1-8476-c90a038d0006" />   
<img width="1539" height="931" alt="image" src="https://github.com/user-attachments/assets/90e04cd8-adcb-4564-8487-3cad041f8f55" />

---  

- [X] **First backup of synthetic test data**

- What I did: Created a folder of synthetic test files (`~/ag3-testdata`) standing in for the agribusiness's data; dummy invoices, livestock records, and supplier lists. Ran `restic backup` to create the first encrypted snapshot in MinIO, verified it appeared with `restic snapshots`, checked repository health with `restic check`, and confirmed the backed-up files with `restic ls latest`.

- Issues faced and fixed: Typos in the export commands — accidentally typed `_AWS_ACCESS_KEY_ID` (extra underscore) and esport instead of export, so credentials didn't load, and `restic init` wrongly tried to create a new repository. Fixed by retyping all four exports correctly; confirmed the original repository (046d89d6) was intact and no duplicate was made. Confused about where the data went; couldn't see my files in the MinIO console. Learned this is correct behaviour: Restic stores data as encrypted, deduplicated blocks (data/, index/, snapshots/), not readable files, so the storage layer shows only scrambled blobs. Confirmed the real files are recoverable using restic ls latest.

- Outcome: First backup succeeded; snapshot saved, listed correctly, passed integrity check, and file contents confirmed via Restic. The Restic ↔ MinIO backup pipeline is proven end-to-end for storing data.

- What I learned: Backups are viewed through Restic, not by browsing MinIO; the encrypted storage structure is the security feature working as intended; restic check guards against the "backup that can't restore" risk; exact command spelling matters.

<img width="1342" height="824" alt="image" src="https://github.com/user-attachments/assets/d2e49f19-29f8-464d-bb35-7b096623276b" />  
<img width="1398" height="854" alt="image" src="https://github.com/user-attachments/assets/1cafa45e-2dbc-4d91-a67b-a2c9c53b9342" />  
<img width="1360" height="873" alt="image" src="https://github.com/user-attachments/assets/42a2dadf-aab7-4479-8264-f6a34dcdb588" />  
<img width="1347" height="838" alt="image" src="https://github.com/user-attachments/assets/7419a9d7-1f1f-4070-b732-ad28c74fa736" />  


_This is the actual backup — Restic reads the folder, encrypts it, and stores a "snapshot" (a point-in-time copy) inside MinIO._  

---  

- [x] **Test restore from snapshot**

- What I did: Verified the recovery half of the backup pipeline. Recorded the original test files as a baseline, deleted them with `rm -rf ~/ag3-testdata` to simulate data loss, then restored from the latest snapshot using `restic restore latest --target ~/ag3-restored`. Confirmed all three files came back with matching contents.

- Issues faced and fixed: The restored files were not where I was told to look. The AI-suggested path `~/ag3-restored/root/ag3-testdata` returned "No such file or directory." I investigated manually with `ls -R ~/ag3-restored` and discovered the files were actually under my own username — `~/ag3-restored/home/faysal-12281612/ag3-testdata`. Restic preserves the original absolute path of the backed-up data, so a `/root/` path would only apply if the backup had been taken as the root user. I corrected this myself before the task could be completed. A file count returned 0 at one point, caused by a typo when retyping the long path. Fixed by using `cd` to navigate into the folder directly rather than retyping it.

- Outcome: Restore succeeded — "Restored 6 files/dirs (142 B)" — and all three synthetic files (invoice001.txt, livestock.txt, suppliers.txt) were recovered intact with contents matching the originals. The backup-and-recovery pipeline is proven end-to-end.

- What I learned: Restic restores preserve the original file path structure under the target directory; `ls -R` is the reliable way to inspect an unfamiliar restore layout; navigating with `cd` avoids retyping errors; and guidance — including AI guidance — must be verified against the actual system rather than assumed correct.

<img width="1321" height="855" alt="image" src="https://github.com/user-attachments/assets/03718ae9-70af-49a6-8be6-79252db26ff5" />

<img width="1307" height="824" alt="image" src="https://github.com/user-attachments/assets/535128ba-d874-47f2-9201-82f5d0f9a1a2" />  

_I deleted all the files using `rm -rf ~/ag3-testdata`, assuming the folder had been lost due to a ransomware attack. After that, I successfully recovered the folder with `restic restore latest --target ~/ag3-restored`. The next photo shows proof of the successful recovery._

<img width="1315" height="840" alt="image" src="https://github.com/user-attachments/assets/8c5bb5bc-80fd-4c8f-9116-d40c6139a561" />  


---

- [ ] **Prove MinIO backup isolation (start)**

**Transfer this task to Week 6**

---


## Evidence to collect this week
| Tasks | Status |  
|---|---|  
| Screenshot of successful repository initialisation | Done |  
| Screenshot of `restic snapshots` and `restic check` output | Done |  
| Screenshot of a successful restore | Done |  
| Proof that a normal office account cannot reach MinIO |  In Progress |  
| All committed to this folder with dated filenames | NOT Started Yet |
| Plan For Week 6 | NOT Started Yet |  
