# Learning References — Faysal

Sources I used to learn the tools and concepts for my backup and recovery workstream.
Listed in the order I used them.

---

## 1. MinIO setup and configuration tutorial (YouTube)

- **Link:** https://www.youtube.com/watch?v=7orBkIQ15q0
- **Date used:** 2026-08-06
- **Status:** Completed
- **Type:** Free video tutorial

### What I used it for
Understanding MinIO installation, bucket creation, and access-key management before
building the isolated backup target for AG-3.

### How it applied to my work
Watched before setting up the environment in Week 5. It gave me enough working knowledge
to install the MinIO server, create the `test-01-ag3-backups` bucket, and understand the
access keys that Restic later uses to authenticate against it.

### Limitation identified
The tutorial covers standard MinIO setup only. It did **not** cover user and policy
management, which I later found is absent from the MinIO Community Edition web console
entirely. That gap is what led to card #42 (installing the `mc` command-line client),
since `mc` is the only way to create the restricted account needed for the isolation
test in card #43.

---

## 2. AWS: Data Management and Backups (Whizlabs, via Coursera)

- **Link:** https://www.coursera.org/learn/aws-data-management-and-backups/home/welcome
- **Date started:** 2026-08-16
- **Status:** In progress — Module 1 of 2
- **Type:** Paid course (self-funded)

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/734a9385-bc50-4c04-9b23-23de56f5b627" />


### Why I enrolled
Self-directed learning to close the two weakest areas identified in my Assessment 1
Part B learning plan: **scripting/automation** and **integrity verification**. Week 5
gave me hands-on experience installing and testing the tools, but scheduled automation
and integrity verification are still ahead of me.

### How it applies to AG-3
The course teaches AWS services rather than Restic and MinIO, so the tooling is not a
direct match. The underlying principles do transfer:

| Course topic | Applies to my workstream |
|---|---|
| Backup scheduling and frequency | Card #46 (scheduling research) and the automated 4-hourly backups deployed in Week 7 |
| Retention and lifecycle policies | Retention policy work in Weeks 7–8 (`restic forget` / `prune` strategy) |
| Storage tiering and durability | Justifying MinIO as the isolated backup target in the final report |
| Recovery objectives (RTO/RPO) | Timed recovery test in Week 11 — targets: RTO 2 hours, RPO 4 hours |

---

## Note on scope and citation

Both sources are **background learning, not project implementation**. No content from
either is copied into project artefacts. Where the final report requires an authoritative
citation, I use the official [Restic](https://restic.readthedocs.io) and
[MinIO](https://docs.min.io) documentation rather than tutorial or course material.

---
