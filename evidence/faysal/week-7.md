# Week 7 — Backup Workstream Progress (Faysal)

**Goal:** Turn the manual backup into an automated one — config file, backup script, 4-hourly schedule, failure test, retention policy, and JSON logging for Wazuh.

## Kanban status

| # | Card | Status |
|---|---|---|
| #45 | Create environment config file | Done |
| #53 | Write automated backup script | Done |
| #54 | Schedule backup every 4 hours | Done |
| #55 | Test deliberate backup failure | Done |
| #56 | Apply retention policy | Done |
| #61 | Move backup server to VLAN 40 | Done |
| #57 | Backup status to Wazuh | My side done — agent pending |
| #58, #62, #63, #44, #59 | — | Carried to Week 8 |

<img width="1918" height="1043" alt="image" src="https://github.com/user-attachments/assets/7fe18b48-5acc-4aeb-8ae3-bd1805c9bbf4" />
<img width="1919" height="1043" alt="image" src="https://github.com/user-attachments/assets/17fe1bca-c5c0-488a-b507-986746bc04f4" />

---

## Tasks

- [X] **Create environment config file (#45)**

- What I did: Created `config/.env` with all eight settings (MinIO credentials, endpoint, Restic keys, repository path and password, backup source). Set `chmod 600` and added it to `.gitignore`.

- Why: Four commands failed in Weeks 5–6 because I retyped variables by hand. A config file removes that error entirely and is required for any script that runs unattended.

- Issues faced and fixed: The repo wasn't on the VM (I'd been committing from Windows) — installed git and cloned it. `~/ag3-testdata` was gone from the Week 5 restore test — recovered it from `~/ag3-restored/`.

- Outcome: `restic snapshots` opened repository `5b3977bc` with zero manual exports. `config/.env` is invisible to git.

- What I learned: `export` only lasts one terminal session. A config file loads everything at once, which is what makes automation possible.

<img width="1339" height="836" alt="image" src="https://github.com/user-attachments/assets/9033f594-9b03-45a0-a8bd-8eea3fab8ed8" />
<img width="1335" height="814" alt="image" src="https://github.com/user-attachments/assets/b4adbbcf-9ff5-4c62-a5c9-9b07032d51c6" />

---

- [X] **Write automated backup script (#53)**

- What I did: Wrote `scripts/backup.sh` — loads the config, runs `restic backup`, runs `restic check`, logs the result. Exits non-zero on failure so cron and Wazuh can detect it.

- Outcome: Exit code 0. Snapshot `48b9e2fc` saved, integrity check passed, run took 2 seconds.

- What I learned: Restic only stored what changed rather than copying everything again. Also, exit code 0 only means the script finished — reading the log is what proves a snapshot was actually created.

<img width="1462" height="161" alt="image" src="https://github.com/user-attachments/assets/4d8e3561-abc0-4464-8ad4-b5a81fa4228b" />
<img width="1391" height="871" alt="image" src="https://github.com/user-attachments/assets/497cb401-f5c3-4837-a3b8-a3dc6cd4a521" />
<img width="1374" height="488" alt="image" src="https://github.com/user-attachments/assets/71b93805-3094-4919-bfc2-56b7d788f5f5" />
<img width="1315" height="218" alt="image" src="https://github.com/user-attachments/assets/10f52ff4-ca53-41d2-9ed8-5627bb5583b8" />

---

- [X] **Schedule backup every 4 hours (#54)**

- Decision: Chose cron over systemd timers — one line, already installed, and my script does its own logging.

- What I did: Added `0 */4 * * *` to cron, so the backup runs six times a day. Also made MinIO a systemd service so it starts automatically at boot.

- Why 4 hours: The Project Proposal commits to an RPO of 4 hours. This schedule is what makes that number real.

- Issues faced and fixed: Two problems. First, cron runs with a stripped environment and often fails with "command not found" — I tested this with `env -i` and it passed. Second, MinIO was only being started by hand, so a backup after a reboot would have failed. Fixed with a systemd service using `Restart=always`.

- Outcome: After a full reboot, MinIO started by itself at 10:47:44 and the cron schedule was still there. The automation is genuinely unattended.

- What I learned: Scheduling the backup was easy. The real work was making sure the storage server it depends on comes back on its own.

<img width="1394" height="944" alt="image" src="https://github.com/user-attachments/assets/c35318af-ff07-4ad1-a1a1-e6ae084fbb57" />

---

- [X] **Test deliberate backup failure (#55)**

- What I did: Saved a copy of the config, replaced the Restic password with an invalid one, ran the script, then restored the correct config.

- Why: A backup that fails silently is worse than no backup, because it creates false confidence. I needed to see a failure detected before trusting a success.

- Outcome: Exit code **1** with `"status":"failure"` logged. After restoring the config, exit code 0 and `"status":"success"` again. Both paths proven.

- What I learned: Backing up the config first made the test safe to reverse. Never leave a deliberately broken system unattended — restore and re-verify in the same sitting.

<img width="1444" height="903" alt="image" src="https://github.com/user-attachments/assets/ab3d13d9-f9a8-44bf-8046-316ff375f63e" />

---

- [X] **Apply retention policy (#56)**

- What I did: Ran `restic forget --keep-hourly 6 --keep-daily 7 --keep-weekly 4 --keep-monthly 6` with `--dry-run` first, checked what it would delete, then re-ran with `--prune`. Documented it in `config/retention-policy.md`.

- Why: Six backups a day means about 2,200 a year. Retention keeps a useful spread and stops the repository growing forever.

- Outcome: 6 snapshots reduced to 3. The three removed were near-identical test runs from within 24 minutes of each other. 513 B reclaimed, and `restic check` passed afterwards.

- What I learned: One snapshot can satisfy several rules at once — the newest counted as hourly, daily, weekly and monthly together. `forget --prune` is the only destructive command in my workstream, so dry-run first, always.

---

- [~] **Backup status to Wazuh (#57) — my side done**

- What I did: Tanvi specified JSON at `/var/log/cyber-resilience/backup.json` with nine named fields, one event per attempt, no credentials. I created the log directory and rewrote the script to write a single JSON line on every exit path.

- Outcome: Both event types verified — success and failure each write correct JSON.

- Outstanding: My VM needs its own Wazuh agent connected to MON01. Couldn't do it in the lab because Tanvi's VLAN wasn't reachable.

- What I learned: Writing logs for a machine is different from writing them for a person. My original format was readable but Wazuh would have had to guess where the status was. Agreeing the format with Tanvi first avoided building it twice.

---

- [X] **Move backup server to VLAN 40 (#61)**

- What I did: Added a second network adapter in VirtualBox — Adapter 1 stays on NAT for internet, Adapter 2 bridged to the Ethernet port. Set the static IP 10.20.40.10 through NetworkManager.

- Issues faced and fixed: The bridged adapter was pointed at the Wi-Fi card instead of Ethernet, and showed no link. Once fixed, it picked up 192.168.50.104 by DHCP, which isn't our addressing — I reported it to Akib and he moved my port to VLAN 40.

- Outcome: `enp0s8` holds 10.20.40.10/24 permanently, and `ping 10.20.40.1` returns 0% packet loss.

- What I learned: Having an IP address and having working connectivity are two different things. Reporting the exact symptom to Akib was more useful than saying it didn't work.

<img width="1316" height="827" alt="image" src="https://github.com/user-attachments/assets/3c71690b-c44c-474e-9a2e-5bf56d63e5ca" />

---

## Problem faced in the lab session

**What worked:** My server is correctly on VLAN 40 at 10.20.40.10, and I can reach my gateway 10.20.40.1 with 0% packet loss. My side is complete.

**What didn't:** I couldn't reach Shourab's Nextcloud (10.20.20.10) or Tanvi's Wazuh (10.20.30.10) — 100% packet loss to both.

**What we found:** Neither Shourab nor Tanvi could ping their own gateways either, so their VLANs weren't working from their end. One useful clue on my side: `nc -zv 10.20.20.10 22` returned **Connection refused** rather than timing out, which means something did answer at that address — so the path isn't completely dead.

**Why we stopped:** Diagnosing this properly needed more time than our lab booking allowed, so we left it rather than making changes we couldn't verify.

**Plan:** Fix inter-VLAN connectivity this week and get all devices communicating before the next session. Open questions: is ICMP blocked between VLANs by design (Akib's rules only mention TCP 9000 and 9001), and were APP01 and MON01 actually running?

---

## Carried to Week 8

| # | Card | Blocked by |
|---|---|---|
| #58 | Refine #43 with scoped policy | Nothing — can start now |
| #62 | Re-verify backup after IP change | Needs `.env` updated to 10.20.40.10 |
| #57 | Wazuh agent install | Needs MON01 reachable |
| #63 | Back up real Nextcloud data | Needs APP01 reachable + data path |
| #44 | Network isolation test | Needs inter-VLAN connectivity |
| #59 | Document ports for Akib | Just needs writing up |

---

## Evidence collected

| Item | Status |
|---|---|
| `.env` gitignored and `chmod 600` | Done |
| `scripts/backup.sh` committed | Done |
| Successful script run + `restic check` | Done |
| cron + systemd configuration | Done |
| Reboot test — MinIO auto-started, cron intact | Done |
| Deliberate failure with non-zero exit | Done |
| Retention policy + before/after counts | Done |
| JSON log showing success and failure | Done |
| Static IP on VLAN 40 + gateway ping | Done |
| Wazuh dashboard screenshot | Week 8 |
| Scoped-policy test result | Week 8 |

---

## Risks for Week 8

1. **Inter-VLAN connectivity is the critical path** — three of my cards (#44, #57, #63) depend on it. Raise it early, not at the next lab session.
2. **`config/.env` still points at 127.0.0.1** — works only because MinIO is local. Must change to 10.20.40.10 and be re-verified (#62).
3. **Shourab's Nextcloud has folders but no data** — backing up empty folders proves nothing. Ask him to add files before #63.
