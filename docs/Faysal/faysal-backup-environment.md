# Backup Environment Build — Faysal

Reproducible build documentation for the AG-3 backup environment.

## Virtual machine
| Setting | Value |
|---|---|
| VM name | AG3-Backup-Server |
| Host platform | Oracle VirtualBox on Windows |
| Guest OS | Ubuntu Desktop 26.04 |
| RAM / CPU / Disk | 4 GB / 2 CPUs / 30 GB (dynamic VDI) |
| Network | NAT (secure overlay VPN planned for team access) |
| Disk encryption | None — Restic encrypts the backups instead |
| Filesystem | ext4 (default) |

## Tools installed
| Tool | Version | Install method |
|---|---|---|
| Restic | 0.18.1 | `sudo apt install restic` |
| MinIO Server | RELEASE.2025-09-07 | Official binary from dl.min.io to /usr/local/bin/ |
| MinIO Client (mc) | Pending Week 6 | Required for user management |

## MinIO runtime
- Start command: `minio server ~/minio-data --console-address ":9001"`
- API port 9000 (Restic connects here) | Console port 9001 (browser access)
- Data directory: ~/minio-data
- Bucket: test-01-ag3-backups
- Runs in the foreground and must stay in its own terminal

## Restic repository
- Repository points at the MinIO bucket over the S3 API
- Encrypted at rest; the repository password is required for all access and is stored
  securely outside this repository
- Repository ID: 5b3977bcb8

## Restore behaviour
Restic restores preserve the **original absolute path** of the backed-up data. Files backed up
from `/home/<username(faysal-12281612)>/ag3-testdata` restore to `<target>/home/<username(faysal-12281612)>/ag3-testdata`, not
directly into the target folder. Use `ls -R <target>` to map the structure after a restore.

## Known constraints
- MinIO Community Edition's console provides only an Object Browser; user and policy
  management requires the `mc` command-line client.
- Environment variables (MinIO credentials, Restic repository path and password) are
  session-only and clear on restart. A config file to load them is planned for Week 6.
- The environment currently runs locally behind NAT. A secure overlay
  (Tailscale/ZeroTier/WireGuard) is planned to make it team-accessible.

## Security note
No real credentials or secrets are committed to this repository.
