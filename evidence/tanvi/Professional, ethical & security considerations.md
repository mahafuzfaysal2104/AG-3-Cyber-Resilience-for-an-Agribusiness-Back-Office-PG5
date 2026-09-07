# Professional, ethical and security considerations

Professional conduct is applied through the way the lab is built, tested and documented. The team will follow these controls:

1. **Authorisation and safe scope.** Tests will run only on systems owned or explicitly approved for the project. Real ransomware, uncontrolled scanning and destructive activity outside a dedicated test location are prohibited.
2. **Synthetic and minimal data.** APP01 and BKP01 will contain synthetic records only. Monitoring will collect only the events required to demonstrate security and recovery.
3. **Protection of credentials and identifiers.** Passwords, API keys, tokens and recovery secrets will not be committed to GitHub or displayed in the report. Screenshots will be checked for personal details, unnecessary addresses and credentials before submission.
4. **Least privilege and segmentation.** Service accounts and firewall rules will permit only the sources, destinations and ports required for monitoring and backup. Netgate recommends documenting the purpose of firewall and NAT rules so their continued need can be reviewed (Netgate 2025c).
5. **Controlled change and rollback.** Before higher-risk remediation, the current configuration and relevant package versions will be recorded and a snapshot created. Changes will be applied incrementally and rescanned. The `jupyter-core` remediation and CIS module changes followed this method.
6. **Evidence integrity.** Screenshots and logs will retain the relevant timestamp, agent, event and result. Evidence will not be edited in a way that changes its technical meaning, and failed tests will be reported rather than hidden.
7. **Responsible vulnerability handling.** Findings will be validated before remediation. A dashboard count alone will not be used to claim that a system is secure, and changes will consider operational impact.
8. **Licensing and attribution.** Third-party software, documentation, code and diagrams will be used according to their licences and acknowledged through citations.
9. **Responsible AI use.** AI-assisted drafting or troubleshooting will be critically reviewed, corrected against actual evidence and recorded in `AI-log.md` where required. Each member remains responsible for understanding and explaining submitted material, consistent with the assessment’s AI-collaboration conditions (CQUniversity 2026).
10. **Professional collaboration.** Workstream owners will communicate configuration requirements early, record decisions and blockers, and avoid making uncoordinated address or firewall changes that interrupt another member’s system.

These controls show that safety, privacy and accountability are part of the implementation process. They also ensure that the report distinguishes verified results from planned work and does not overstate the project’s current level of resilience.
