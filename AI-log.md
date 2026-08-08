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

## 2026-08-06 — Understanding Restic and MinIO for the backup workstream _ (Faysal)
- Tool: Claude (Anthropic)
- Prompt: "Explain why we are using Restic and MinIO, because it might get hacked by ransomware attack, cause it also tries to find out the backups. How will these work together?"
- What it produced: a conceptual explanation of the roles of Restic (encrypted backup engine that creates point-in-time snapshots) and MinIO (isolated S3-compatible storage that ransomware cannot reach), and how they combine into a ransomware-resilient backup-and-recovery pipeline for the AG-3 Nextcloud data
- What we changed and why: used it only to build my own understanding before configuring the tools; no text was copied into the report — I will write the design justification in my own words and cite the official MinIO and Restic documentation as the authoritative sources
- How we validated it: cross-checked the explanation against the official Restic and MinIO documentation, and confirmed it in practice by initialising a working encrypted repository (Task #22)
<img width="784" height="638" alt="image" src="https://github.com/user-attachments/assets/676f58ac-bfdb-4aa5-bbbb-acc203e3d63b" />
