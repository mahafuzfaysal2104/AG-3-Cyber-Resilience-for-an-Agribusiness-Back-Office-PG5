# /scripts

Automation code — Bash / Python / PowerShell / Ansible.

Planned scripts:

- `backup.sh` — scheduled Restic backup to MinIO, run every 4 hours (Faysal)
- `simulate-ransomware.sh` — safe, path-restricted synthetic file-change simulation, dry-run by default (Faysal)
- `hardening-check.sh` — before/after OS hardening verification (Tanvi)
- `firewall-test.sh` — allowed vs blocked connectivity test automation (Akib)

Commit convention: `feat:` for new scripts, `fix:` for bug fixes, `test:` for test/verification scripts.
