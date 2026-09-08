# Risk identification and mitigation

The risk register is treated as a working project control rather than a one-time document. Risks are assessed using likelihood (L) and impact (I) values from 1 (low) to 5 (very high), with the initial score calculated as L × I. This approach supports prioritisation and regular review, consistent with NIST guidance that risk assessment should consider threats, vulnerabilities, likelihood and impact and should inform risk responses (NIST 2012).
This assessment evaluates the risks that could prevent the team from delivering a working and defensible cyber-resilience solution for the representative agribusiness. It covers APP01 (Nextcloud and identity), pfSense and VLAN segmentation, MON01 (Wazuh monitoring and endpoint hardening), and BKP01 (MinIO and Restic backup and recovery). It considers both technical security risks and delivery risks.

The assessment is based on demonstrated progress, not installation claims alone. A control is treated as effective only where the repository or captured evidence shows a configuration, test result, log, screenshot, or repeatable command. Work that is locally complete but not yet proven across the team network remains an open integration risk.  
| Workstream | Evidence-based progress | Remaining gap affecting risk |
|---|---|---|
| APP01 - Nextcloud and identity | Ubuntu, Apache, PHP, MariaDB and Nextcloud are installed. MariaDB was hardened; Nextcloud data is outside the web root; caching and file locking were configured; HTTPS redirects and HSTS were implemented; role-based Team Folders, quotas and administrator TOTP were configured. | Production VLAN address and cross-system access still need final verification. Negative access tests, MFA recovery and certificate trust remain to be demonstrated. |
| Network - pfSense and VLANs | pfSense 2.7.2, VLANs 10/20/30/40/99, aliases, addressing plan and initial least-privilege firewall rules are documented. BKP01 has reached its VLAN 40 gateway. | Approved and denied paths have not been comprehensively evidenced. APP01 and MON01 did not consistently reach their gateways during integration attempts. Firewall denial logs are still required. |
| MON01 - Wazuh and hardening | Agent 001 is active. Controlled SSH activity produced 12 authentication-failure alerts. FIM detected add, modify and delete events using rules 554, 550 and 553. `jupyter-core` was upgraded from 4.10.0 to 4.11.2 and high findings reduced from 8 to 6. CIS SCA improved from 45% to 49% (82 to 89 passed). | APP01 and BKP01 agents/logs are not yet confirmed in MON01. Remaining vulnerabilities and 92 CIS failures need risk-based review and tuning. |
| BKP01 - MinIO and Restic | Encrypted Restic repository, scripted backup and integrity check, deliberate failure logging, four-hour cron schedule, MinIO auto-start, retention policy, restricted user denial and VLAN 40 address are evidenced. | Backup over the production network address, real Nextcloud data backup, Wazuh event ingestion, network isolation, and a timed end-to-end restore are still pending. |


##  Risk register

| ID | Risk and consequence | Inherent | Current controls and evidence | Residual | Status | Required treatment, evidence and owner |
|---|---|---:|---|---:|---|---|
| R-01 | **Inter-VLAN integration fails.** APP01, MON01 and BKP01 cannot exchange the required traffic, preventing monitoring, backup and recovery. | 4x5=20 Extreme | Addressing and VLAN design are documented. BKP01 at `10.20.40.10/24` reached gateway `10.20.40.1`. pfSense interfaces and initial rules exist. | 4x5=20 Extreme | Open - critical path | Akib with all system owners: verify switch port/VLAN assignments, gateway reachability and pfSense routing. Test required ports, not ping alone. Record an allowed-path result for APP01-to-BKP01 and APP01/BKP01-to-MON01. |
| R-02 | **Firewall rules are too broad or too restrictive.** Broad rules could expose backups or management services; restrictive rules could stop business and security services. | 3x5=15 High | Separate VLAN rule sets, IP/port aliases and final deny rules are documented. Planned access includes APP01 to BKP01 TCP 9000 and Wazuh ports 1514/1515. | 3x4=12 High | Partially treated | Akib: create an approved traffic matrix, test every allow and deny case, and retain pfSense logs showing blocked Office-to-BKP01 traffic while the authorised APP01 path succeeds. |
| R-03 | **A backup completes but real data cannot be restored.** The organisation could suffer prolonged data loss despite apparently successful jobs. | 4x5=20 Extreme | Restic repository, sample backup, sample restore and `restic check` have been demonstrated. The script returns meaningful exit codes and performs an integrity check. | 3x5=15 High | Partially treated | Faysal with Shourab: back up representative Nextcloud data and database material, restore to a clean location, compare file counts and SHA-256 hashes, and record start/finish times. Confirm the agreed RTO and RPO. |
| R-04 | **The four-hour RPO is missed because automation stops after reboot or cron cannot load its environment.** | 3x4=12 High | A `0 */4 * * *` cron schedule is configured. The script was tested with a restricted environment, MinIO runs as a systemd service, and a reboot test retained the schedule and restarted MinIO. | 2x4=8 Moderate | Controlled; verification pending | Faysal: capture `restic snapshots` showing unattended runs approximately four hours apart over several days and alert on missed/failed runs. |
| R-05 | **A compromised office account or host can reach and alter the backup repository.** Ransomware could affect both source data and recovery copies. | 4x5=20 Extreme | A restricted MinIO account authenticated but received `Access Denied` to the backup bucket. Secrets are stored in a mode-600 `.env` excluded from Git. BKP01 is assigned to VLAN 40 and retention is configured. | 3x5=15 High | Partially treated | Faysal and Akib: demonstrate targeted least privilege (access to a permitted non-backup bucket but denial to the backup bucket), deny Office VLAN access at pfSense, restrict MinIO API/console sources, and preserve evidence of both allowed and denied paths. |
| R-06 | **Security events from APP01 or BKP01 are not visible in Wazuh.** Backup failure, authentication attacks or file changes could go unnoticed. | 4x4=16 High | MON01 detects local authentication and FIM events. BKP01 produces one-line JSON success/failure events at `/var/log/cyber-resilience/backup.json`. APP01 records failed Nextcloud logins. | 4x4=16 High | Open - critical integration gap | Tanvi with Faysal and Shourab: install/connect unique Wazuh agents, collect the agreed logs, generate one controlled success and failure event per service, and confirm host, time, rule, status and severity in the dashboard. |
| R-07 | **Wazuh creates alert fatigue or misleading results.** Important incidents may be overlooked among noisy or duplicated alerts. | 3x3=9 Moderate | Tests use known events and compare source logs with dashboard results. Monitoring is currently limited to selected test paths and event types. | 2x3=6 Moderate | Ongoing | Tanvi: document the baseline event rate, tune noisy rules and exclusions, keep backup success lower severity than failure, and verify that tuning does not hide the controlled test alerts. |
| R-08 | **Known vulnerabilities remain exploitable, or remediation breaks dependencies.** | 4x4=16 High | A VM snapshot and package inventory were captured before changing `jupyter-core`. The package moved from 4.10.0 to 4.11.2 and Wazuh high findings fell from 8 to 6. | 3x4=12 High | Partially treated | Tanvi: validate each remaining finding against the installed package source and actual exposure; remediate one change at a time; retest Wazuh, Python/Jupyter dependencies and endpoint operation; document accepted exceptions. |
| R-09 | **CIS hardening disables a required kernel module, filesystem or service.** | 3x4=12 High | Filesystem use was checked before changes, unused modules were disabled incrementally, and a rollback snapshot exists. The SCA score improved from 45% to 49%. | 2x3=6 Moderate | Controlled for completed changes | Tanvi: continue only with controls that fit the lab's operational needs, record before/after check IDs, test services after each batch, and treat the 49% score as a guide rather than proof of full compliance. |
| R-10 | **Nextcloud access control or MFA is bypassed or causes lockout.** Unauthorised users could see sensitive department data, or administrators could lose access. | 3x5=15 High | Nine groups, six Team Folders, role-based permissions, quotas and administrator TOTP are configured. MariaDB uses local least-privilege access, and Redis locking was repaired and verified. | 2x4=8 Moderate | Partially treated | Shourab: capture negative folder-access tests, password-only/MFA tests, backup-code recovery and a second authorised administrator procedure. Review whether MFA must cover privileged and other high-risk users, not only the main administrator. |
| R-11 | **Users ignore certificate warnings or connect to an untrusted endpoint.** A self-signed certificate encrypts traffic but does not provide external identity assurance. | 3x4=12 High | HTTPS, HTTP-to-HTTPS redirection and HSTS are configured; a 4096-bit self-signed certificate supports lab encryption. | 3x3=9 Moderate | Accepted for lab; not production-ready | Shourab: document the lab trust limitation, distribute/verify the certificate fingerprint through an approved channel, and use a trusted internal or public CA for any production-like deployment. |
| R-12 | **Credentials, configuration secrets or personal data are exposed in GitHub or screenshots.** | 3x5=15 High | Real `.env` credentials are excluded by `.gitignore` and permissions are restricted. The team states that screenshots/configuration should be sanitised. | 2x5=10 High | Ongoing | All members: rotate any credential already shown in evidence, scan commit history and pfSense exports before submission, use synthetic data, redact secrets and identifiers, and never publish recovery keys or tokens. |
| R-13 | **The simulated data-loss event damages real data or backups.** | 3x5=15 High | The planned simulation reproduces data loss rather than using malware. It is limited to a designated test directory, requires a verified snapshot, excludes MinIO, and uses a confirmation step. | 1x5=5 Moderate | Planned control | Faysal and team: obtain mentor approval, review the allow-listed path, rehearse on a disposable copy, notify the team, and stop if the target or clean restore point cannot be verified. |
| R-14 | **Integration delays and incomplete evidence prevent the MVP or assessment from being accepted.** Locally completed work may not demonstrate an end-to-end outcome. | 4x4=16 High | Workstream owners, weekly meeting, Kanban cards, repository evidence and staged Week 8-11 planning are defined. | 3x4=12 High | Open | Team lead and all owners: resolve networking first, then complete Wazuh ingestion, real-data backup, isolation and timed recovery. Update checklists honestly, link evidence to requirements, and review the register weekly. |

##  Priority treatment plan

The team should address the risks in dependency order:

1. **Restore network reachability (R-01 and R-02).** Confirm VLAN tagging, switch ports, gateways, routing and minimum firewall rules. This unlocks all cross-system tests.
2. **Connect APP01 and BKP01 to MON01 (R-06).** Use unique agents and prove that Nextcloud and backup events arrive with the correct host and severity.
3. **Prove backup isolation and real-data recovery (R-03 and R-05).** Demonstrate one authorised connection, one denied connection and one verified restore of representative Nextcloud content.
4. **Close high residual security risks (R-08, R-10 and R-12).** Continue vulnerability remediation, complete IAM negative/recovery tests, and audit the repository for exposed secrets.
5. **Run the safe timed simulation only after prerequisites pass (R-13).** Measure RTO, RPO, file count and hashes and retain the full evidence trail.

##  Overall risk conclusion

The project has moved beyond a design-only stage. APP01, MON01 and BKP01 each have meaningful local controls, and pfSense segmentation is substantially configured. The strongest verified outcomes are Wazuh authentication/FIM detection, selected vulnerability and CIS improvements, Nextcloud hardening and role-based access, and automated encrypted backup with controlled success/failure logging.

However, the current overall delivery risk remains **High** because the most important resilience claim is end-to-end: protected application data must cross the intended network path, be monitored, be backed up into an isolated repository and be restored within the agreed objective. Until those linked tests are completed, local component success cannot be treated as proof that the whole environment is resilient.

##  Evidence and references

- CQUniversity 2026, *COIT20265 Assessment Item 2: Individual Progress Report*, Term 2 2026.
- Group PG5 2026, *AG-3 Cyber Resilience for an Agribusiness Back Office*, GitHub repository, evidence reviewed 7 September 2026.
- National Institute of Standards and Technology 2012, *Guide for Conducting Risk Assessments*, NIST SP 800-30 Revision 1.
- Oracle 2024, *Oracle VM VirtualBox User Guide: Snapshots*.
- Wazuh 2026, *File Integrity Monitoring*, *Vulnerability Detection* and *Security Configuration Assessment* documentation.
- Netgate 2025, *pfSense VLAN and Firewall Rules* documentation.


# References

CQUniversity 2026, *COIT20265 Assessment Item 2: Individual Progress Report, Term 2 2026*, assessment specification supplied through the unit Moodle site.

National Institute of Standards and Technology (NIST) 2012, *Guide for Conducting Risk Assessments*, Special Publication 800-30 Revision 1, US Department of Commerce, viewed 7 September 2026, <https://csrc.nist.gov/pubs/sp/800/30/r1/final>.

Netgate 2025a, *VLAN configuration*, pfSense Documentation, viewed 7 September 2026, <https://docs.netgate.com/pfsense/en/latest/vlan/configuration.html>.

Netgate 2025b, *Configuring firewall rules*, pfSense Documentation, viewed 7 September 2026, <https://docs.netgate.com/pfsense/en/latest/firewall/configure.html>.

Netgate 2025c, *Firewall rule best practices*, pfSense Documentation, viewed 7 September 2026, <https://docs.netgate.com/pfsense/en/latest/firewall/best-practices.html>.

Oracle 2024, *Oracle VM VirtualBox User Guide for Release 7.0: Snapshots*, Oracle, viewed 7 September 2026, <https://docs.oracle.com/en/virtualization/virtualbox/7.0/user/EN-VBOX-7-0-USER.pdf>.

Wazuh 2026a, *File integrity monitoring: Proof of Concept guide*, Wazuh Documentation, viewed 7 September 2026, <https://documentation.wazuh.com/current/proof-of-concept-guide/poc-file-integrity-monitoring.html>.

Wazuh 2026b, *Vulnerability detection configuration*, Wazuh Documentation, viewed 7 September 2026, <https://documentation.wazuh.com/current/user-manual/capabilities/vulnerability-detection/configuring-scans.html>.

Wazuh 2026c, *Security Configuration Assessment*, Wazuh Documentation, viewed 7 September 2026, <https://documentation.wazuh.com/current/user-manual/capabilities/sec-config-assessment/index.html>.
