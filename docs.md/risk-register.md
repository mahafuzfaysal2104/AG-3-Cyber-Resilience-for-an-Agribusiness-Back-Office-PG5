# AG-3 Risk Register

A **living** document — reviewed and updated every week, not written once and filed. Covers technical and practical risks (including budget).

| ID | Risk | Likelihood | Impact | Mitigation | Owner | Status |
|---|---|---|---|---|---|---|
| R-01 | Backup completes but restore fails | Medium | High | Test restore independently, not just backup success | Faysal | Open |
| R-02 | Untested backup assumptions | Medium | High | Weekly scheduled-backup review, deliberate failure test | Faysal | Open |
| R-03 | MFA lockout / recovery-code loss | Low | Medium | Document recovery-code process, test account-recovery path | Shourab | Open |
| R-04 | Firewall misconfiguration blocks legitimate traffic | Medium | Medium | Test allowed and blocked paths explicitly | Akib | Open |
| R-05 | Wazuh alert fatigue / noisy false positives | Medium | Low | Tune rules after initial test events | Tanvi | Open |
| R-06 | Credential/secret exposure in GitHub | Low | High | Sanitise all config exports before commit | All | Open |
| R-07 | Ransomware simulation accidentally affects real data | Low | High | Hard-coded path allow-list, dry-run default, mentor approval before running | Faysal | Open |
| R-08 | Cloud/lab budget overrun | Low | Medium | Track usage weekly against agreed budget | All | Open |
| R-09 | Uneven contribution / member unavailability | Low | Medium | Weekly check-in, raise early with tutor if drift appears | All | Open |

*Update this table every Tuesday meeting — add new rows, change status, don't just leave it static.*
