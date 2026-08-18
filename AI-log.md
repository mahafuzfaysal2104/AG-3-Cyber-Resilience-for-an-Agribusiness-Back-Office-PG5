# AI Log

A running list of all important work done with AI.
Write things down as we do them, not later.
We should be able to explain anything the AI helped create — if we can’t explain it, we shouldn’t use it.

## Format

```
## YYYY-MM-DD — short title
- Tool: <which AI tool>
- Prompt: "<the prompt we used>"
- What it produced: <link or short description>
- What we changed and why: <our edits and reasoning>
- How we validated it: < test/review>
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

## 2026-08-07 — Planning the pfSense firewall hardware setup _ (Akib)
- Tool: ChatGPT (OpenAI)
- Prompt: Questions on using an Acer Predator Helios 300 as the pfSense firewall, whether a USB-to-Ethernet adapter would work, required storage space, and whether Cat6 or Cat7 cables were necessary
- What it produced: guidance on using the Acer laptop as a physical pfSense firewall, using the built-in Realtek Ethernet interface together with a USB-to-Ethernet adapter for separate WAN and LAN connections, minimum storage recommendations, and advice that Cat6 was sufficient for the project
- What we changed and why: I used the Acer laptop and existing network hardware instead of buying a dedicated firewall appliance. I selected the USB Ethernet adapter for WAN and the built-in Ethernet interface for LAN. I also used the available SSD for pfSense because it provided more than enough storage for the firewall installation.
- How we validated it: pfSense successfully detected both network interfaces during installation and later showed ue0 and re0 as available interfaces for WAN and LAN assignment.


## 2026-08-07 — Troubleshooting pfSense USB installation failure _ (Akib)
- Tool: ChatGPT (OpenAI)
- Prompt: Help troubleshooting the pfSense installer error "newfs_msdos: Input/output error" and identifying the correct installation disk
- What it produced: troubleshooting steps to identify the USB installer and internal disks, check the pfSense disk names, and avoid selecting the installer USB as the installation destination. It also suggested that the small USB drive could be causing the installation problem
- What we changed and why: I checked the detected disks from the pfSense shell and confirmed that ada0 was the internal 119 GB SSD while da0 was the small USB storage device. I stopped using the original small USB and recreated the pfSense installation media using an 8 GB USB drive.
- How we validated it: after changing to the 8 GB USB, the pfSense installer completed successfully and the system booted from the internal SSD without the previous input/output error.


## 2026-08-08 — Configuring pfSense WAN, LAN and management access _ (Akib)
- Tool: ChatGPT (OpenAI)
- Prompt: Guidance on assigning the pfSense network interfaces, accessing the web interface from another computer, and fixing the problem caused by WAN and LAN being on the same 192.168.1.0/24 network
- What it produced: instructions to assign ue0 as WAN and re0 as LAN, change the LAN network to a different subnet, configure DHCP, and connect the ASUS laptop directly to the pfSense LAN interface
- What we changed and why: I assigned ue0 as WAN and re0 as LAN. Initially the LAN used 192.168.1.1, but this conflicted with the router-side WAN network. For this reason I changed the pfSense LAN address to 192.168.50.1/24 and enabled DHCP for connected management clients.
- How we validated it: the ASUS laptop received an address on the 192.168.50.0/24 network, the default gateway became 192.168.50.1, ping to the pfSense firewall succeeded with 0% packet loss, and the pfSense login page became reachable.


## 2026-08-08 — First Restic backup and understanding encrypted storage _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: Guidance on taking a first Restic backup of synthetic test data, troubleshooting credential/typo errors, and an explanation of why the backed-up files were not visible in the MinIO console
- What it produced: the commands to create synthetic test files, run the backup, verify the snapshot, check integrity, and list backed-up files; identification of two command typos; and an explanation that Restic stores data as encrypted, deduplicated blocks rather than readable files
- What we changed and why: I created my own synthetic test data and ran every command myself; corrected the typos manually; used the explanation only to understand the tool's behaviour — no text was copied into the report, and I will document the design in my own words citing the official Restic documentation
- How we validated it: confirmed in practice — the snapshot saved and appeared in restic snapshots, restic check reported no errors, and restic ls latest listed the correct files, proving the data was stored and recoverable


## 2026-08-10 — Restore test and correcting the AI's restore-path error _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: Guidance on testing a restore from a Restic snapshot, and help troubleshooting why the restored files could not be found at the suggested path
- What it produced: the commands to simulate data loss (`rm -rf`) and restore from the latest snapshot (`restic restore latest --target ~/ag3-restored`), plus a suggested verification path of `~/ag3-restored/root/ag3-testdata`
- What we changed and why: **the AI's suggested path was wrong.** It told me the restored files would be under a `/root/` subfolder, but running that command returned "No such file or directory." I investigated manually with `ls -R ~/ag3-restored` and found the files were actually restored under my own username path — `~/ag3-restored/home/faysal-12281612/ag3-testdata`. Restic preserves the **original absolute path** of the backed-up data, so the `/root/` path would only apply if the backup had been taken as the root user, which mine was not. I corrected the path myself and verified the files from there.
- How we validated it: the restore reported "Restored 6 files/dirs (142 B)"; `ls -R` mapped the true directory structure; `cd` into the correct path plus `ls` and `cat` confirmed all three files (invoice001.txt, livestock.txt, suppliers.txt) were recovered with contents matching the originals
- Lesson recorded: AI output must be verified against the actual system, not assumed correct. In this case, the suggested path was inaccurate for my environment, and I had to investigate and correct it myself before the task could be completed.
