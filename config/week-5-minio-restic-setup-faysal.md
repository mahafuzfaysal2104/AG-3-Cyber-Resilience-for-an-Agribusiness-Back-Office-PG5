# Week 5 — Command Reference (Faysal)
**AG-3 Backup & Recovery Workstream | Restic + MinIO on Ubuntu**

---

# Install Restic
- Refresh the package list: `sudo apt update`
- Install the Restic backup engine: `sudo apt install restic -y`
- Confirm it installed (returned version 0.18.1): `restic version`
- Capture identity + version together for evidence: `whoami && hostname && restic version`

<img width="847" height="467" alt="image" src="https://github.com/user-attachments/assets/905520c9-a3d9-45a6-bc99-4415e2e23958" />


---

# Install MinIO
- Download the official MinIO server binary: `wget https://dl.min.io/server/minio/release/linux-amd64/minio`
- Make the file executable: `chmod +x minio`
- Move it where the system can find it: `sudo mv minio /usr/local/bin/`
- Create the folder where MinIO stores its data: `mkdir ~/minio-data`
- Set the admin username (session-only): `export MINIO_ROOT_USER=PG5`
- Set the admin password (session-only): `export MINIO_ROOT_PASSWORD=PG520265`
- Start the MinIO server and leave this terminal running: `minio server ~/minio-data --console-address ":9001"`
- Then in Firefox: open `http://localhost:9001`, log in, and create the bucket `test-01-ag3-backups`

<img width="1396" height="1032" alt="image" src="https://github.com/user-attachments/assets/5251ed1b-169b-415f-ab54-1e17374e9a6f" />  
<img width="1301" height="810" alt="image" src="https://github.com/user-attachments/assets/78bebece-77f8-4d8d-9f6e-ea3bf1a1897b" />  


> MinIO runs in the foreground and occupies this terminal — all later commands run in a **second terminal**.

---

# Initialise the encrypted Restic repository
*(run in a second terminal)*
- Set the MinIO access key so Restic can authenticate: `export AWS_ACCESS_KEY_ID=PG5`
- Set the MinIO secret key: `export AWS_SECRET_ACCESS_KEY=PG520265`
- Point Restic at the MinIO bucket over the S3 API (port 9000, not 9001): `export RESTIC_REPOSITORY="s3:http://localhost:9000/test-01-ag3-backups"`
- Set the repository encryption password — critical, unrecoverable if lost: `export RESTIC_PASSWORD=restic12281612`
- Create the encrypted repository (run once only): `restic init`
- Verify the repository opens — an empty list is correct for a new repo: `restic snapshots`

**Result:** `Created restic repository 5b3977bc at s3:http://localhost:9000/test-01-ag3-backups`  

<img width="1314" height="833" alt="image" src="https://github.com/user-attachments/assets/3c22af1c-ae38-4d03-9622-b350153da460" />  



---

# First backup of synthetic test data
- Create the test data folder (synthetic only, never real business data): `mkdir ~/ag3-testdata`
- Create a dummy invoice file: `echo "Invoice 001 - Plains Pastoral Co - synthetic test data" > ~/ag3-testdata/invoice001.txt`
- Create a dummy livestock record: `echo "Livestock record - 50 cattle - synthetic test data" > ~/ag3-testdata/livestock.txt`
- Create a dummy supplier list: `echo "Supplier list - synthetic test data" > ~/ag3-testdata/suppliers.txt`
- Confirm the files exist: `ls ~/ag3-testdata`
- Take the backup — creates an encrypted snapshot in MinIO: `restic backup ~/ag3-testdata`
- Verify the snapshot is stored: `restic snapshots`
- Check repository integrity, guarding against the "backup that can't restore" risk: `restic check`
- List the files inside the backup (Restic decrypts the file list): `restic ls latest`

---

# Test restore from snapshot
- Record the baseline file list before simulating loss: `ls ~/ag3-testdata`
- Record the baseline file contents: `cat ~/ag3-testdata/invoice001.txt`
- Simulate data loss — safe, as this is synthetic data with a backup: `rm -rf ~/ag3-testdata`
- Confirm the data is gone: `ls ~/ag3-testdata`
- Restore from the latest snapshot: `restic restore latest --target ~/ag3-restored`
- Map the restored structure, since Restic preserves the original absolute path: `ls -R ~/ag3-restored`
- Navigate into the restored folder (avoids typos on the long path): `cd ~/ag3-restored/home/faysal-12281612/ag3-testdata`
- List the recovered files: `ls`
- Verify the contents match the original: `cat invoice001.txt`

**Result:** `Restored 6 files/dirs (142 B)` — all three files recovered with matching contents.


<img width="1350" height="876" alt="image" src="https://github.com/user-attachments/assets/ccad01e4-2d43-4fd9-b801-86ff13cf41a8" />  


<img width="1333" height="862" alt="image" src="https://github.com/user-attachments/assets/f317ded1-e626-442d-93b9-e4991816e08b" />  


<img width="1344" height="835" alt="image" src="https://github.com/user-attachments/assets/13c9956b-fbe3-468b-84da-042b8fc8a526" />  



> Files restore to `<target>/home/<username>/<original-folder>` — not under `/root/`.

---

# Restarting after a shutdown
Environment variables are session-only and clear on restart.

**Terminal 1 — start MinIO:**
- Set the admin username: `export MINIO_ROOT_USER=PG5`
- Set the admin password: `export MINIO_ROOT_PASSWORD=PG520265`
- Start the server: `minio server ~/minio-data --console-address ":9001"`

**Terminal 2 — reconnect Restic:**
- Set the access key: `export AWS_ACCESS_KEY_ID=PG5`
- Set the secret key: `export AWS_SECRET_ACCESS_KEY=PG520265`
- Set the repository path: `export RESTIC_REPOSITORY="s3:http://localhost:9000/test-01-ag3-backups"`
- Set the repository password: `export RESTIC_PASSWORD=restic12281612`
- Verify — do **not** run `restic init` again, the repository already exists: `restic snapshots`

---

# Quick command reference

| Command | Purpose |
|---|---|
| `restic version` | Confirm Restic is installed |
| `restic init` | Create the encrypted repository (once only) |
| `restic backup <folder>` | Create a snapshot |
| `restic snapshots` | List all save points |
| `restic ls latest` | Show files inside the newest snapshot |
| `restic check` | Verify repository integrity |
| `restic restore latest --target <folder>` | Recover a snapshot |
| `ls -R <folder>` | Map an unfamiliar folder structure |
| `mc admin user add` | Create a MinIO user (Community Edition) |

# Key values

| Item | Value |
|---|---|
| MinIO API port | 9000 (Restic connects here) |
| MinIO console port | 9001 (browser login) |
| Bucket | test-01-ag3-backups |
| Repository ID | 046d89d603 |
| MinIO data path | ~/minio-data |
| Test data path | ~/ag3-testdata |
| Restore target | ~/ag3-restored |
| Restic version | 0.18.1 |
