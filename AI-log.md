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

## 2026-07-29 — Example entry (delete once real entries begin)
- Tool: [AI tool used]
- Prompt: "[prompt used]"
- What it produced: draft systemd timer for 4-hourly Restic snapshots
- What we changed and why: added repository lock check, exit-code logging, retry on transient MinIO errors
- How we validated it: ran 3 manual trigger tests, confirmed snapshot listed in `restic snapshots`, confirmed log entry written
