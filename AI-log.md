# AI Log

Running, dated record of all meaningful AI-assisted work across the team. **Log as you go, not at the end.** You must be able to explain anything AI helped produce — if you can't, don't ship it.

## Format

```
## YYYY-MM-DD — short title
- Tool: <which AI tool>
- Prompt: "<the prompt you used>"
- What it produced: <link or short description>
- What we changed and why: <your edits and reasoning>
- How we validated it: <test / review>
```

## Entries

## 2026-08-05 — Ubuntu VM environment setup in VirtualBox _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: Questions on setting up an Ubuntu Desktop VM in Oracle VirtualBox — how much RAM/CPU/disk to allocate, which network mode to choose for later team access, whether to enable disk encryption, and which filesystem to select
- What it produced: guidance on VM sizing (4 GB RAM, 2 CPUs, 30 GB disk), advice to use NAT now with an overlay VPN planned later for team access, and a recommendation to skip full-disk encryption and use the default ext4 filesystem for a lab VM
- What we changed and why: I made the final VM configuration and account choices myself; chose "No encryption" because Restic encrypts the backups and MinIO provides isolation, so disk encryption was unnecessary; unticked the unattended-install option so I could install manually and keep control of the setup
- How we validated it: completed the install successfully and booted into a working Ubuntu desktop, confirming the chosen settings worked

## 2026-08-06 — Sourcing, installing and connecting Restic and MinIO _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: Questions on where to download the official Restic and MinIO tools, the correct install and run commands, why these two tools are used and how they work together, and help troubleshooting errors during repository setup
- What it produced: the official install methods and sources (Restic via apt, MinIO via the official binary from dl.min.io), the commands to start MinIO and connect Restic to it, a conceptual explanation of the ransomware-resilient backup architecture, and identification of two command typos causing errors
- What we changed and why: I verified each tool came from its official source before installing; adapted all commands to my own environment (username, paths, bucket name test-01-ag3-backups, credentials); no explanatory text was copied into the report — the design justification will be written in my own words and cite the official Restic and MinIO documentation
- How we validated it: confirmed in practice — restic version returned a valid version, the MinIO console loaded and login succeeded, and after fixing the typos restic init created the encrypted repository (046d89d603) and restic snapshots opened it cleanly

## 2026-08-06 — Understanding Restic and MinIO for the backup workstream _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: "Explain why we are using Restic and MinIO, because it might get hacked by ransomware attack, cause it also tries to find out the backups. How will these work together?"
- What it produced: a conceptual explanation of the roles of Restic (encrypted backup engine that creates point-in-time snapshots) and MinIO (isolated S3-compatible storage that ransomware cannot reach), and how they combine into a ransomware-resilient backup-and-recovery pipeline for the AG-3 Nextcloud data
- What we changed and why: used it only to build my own understanding before configuring the tools; no text was copied into the report — I will write the design justification in my own words and cite the official MinIO and Restic documentation as the authoritative sources
- How we validated it: cross-checked the explanation against the official Restic and MinIO documentation, and confirmed it in practice by initialising a working encrypted repository.
<img width="784" height="638" alt="image" src="https://github.com/user-attachments/assets/676f58ac-bfdb-4aa5-bbbb-acc203e3d63b" />
