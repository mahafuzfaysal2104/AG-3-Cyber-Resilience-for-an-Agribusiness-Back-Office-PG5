# Team Risk Assessment

## AG-3 Cyber Resilience for an Agribusiness Back Office

**Unit:** COIT20265 Networks and Information Security Project  
**Group:** PG5  
**Prepared by:** Sheikh Tanvi Mahmud (Student ID: 12297656)  

## Executive summary  

This report assesses the risks affecting the PG5 cyber-resilience solution for a representative agribusiness back office. The environment consists of APP01 running Nextcloud, MON01 running Wazuh, BKP01 providing MinIO and Restic backup services, and pfSense providing VLAN segmentation and firewall control.

The assessment follows NIST SP 800-30 Revision 1. It identifies important assets, relevant threat sources and threat events, vulnerabilities and predisposing conditions, likelihood, impact and resulting risk. It then considers controls already demonstrated by the team and estimates the remaining or residual risk (National Institute of Standards and Technology (NIST) 2012).

**Overall current residual risk: High.** The team has implemented meaningful controls on individual systems. These include Nextcloud hardening and role-based access, Wazuh authentication and file-integrity alerts, selected vulnerability remediation, encrypted backups, restricted MinIO access, and pfSense VLAN configuration. However, the complete resilience chain has not yet been demonstrated from end to end. Network reachability to the MON01 gateway, central ingestion of APP01 and BKP01 events, isolation of the backup repository, and a timed restoration of representative Nextcloud data remain the most important open risks.

The immediate priorities are to repair VLAN 30 connectivity, verify the approved and denied firewall paths, connect APP01 and BKP01 to Wazuh, and demonstrate a complete backup-and-restore exercise. Until these tests are completed, the team should not claim that the integrated environment is fully resilient.

## 1. Purpose and scope

The purpose of this assessment is to identify and prioritise conditions that could prevent the project from protecting agribusiness information and recovering services after a cyber incident or operational failure.

The scope includes:

- **APP01:** Nextcloud, Apache, PHP, MariaDB, user identities, team folders and application data.
- **MON01:** Wazuh monitoring, authentication alerts, File Integrity Monitoring (FIM), vulnerability detection and Security Configuration Assessment (SCA).
- **BKP01:** MinIO object storage, Restic repository, backup scripts, schedules, retention and restoration.
- **Network security:** pfSense, VLANs 10, 20, 30, 40 and 99, physical switch connections, routing, firewall rules and management access.
- **Project delivery:** integration, evidence quality, team coordination and safe testing.

The assessment is evidence based. A control is considered effective only when a configuration, screenshot, command result, log, alert or repeatable test demonstrates its operation. A locally configured component is not treated as an effective end-to-end control until it has been tested across the team network.

The assessment excludes production financial loss calculations because this is an educational prototype and reliable monetary or annual-frequency data are unavailable. It uses a qualitative five-point method, which is permitted by the flexible assessment approach in NIST SP 800-30 (NIST 2012).

## 2. NIST SP 800-30 assessment method

NIST SP 800-30 describes four broad activities: preparing for the assessment, conducting the assessment, communicating the results, and maintaining the assessment. The conduct stage includes identifying threat sources and events, vulnerabilities and predisposing conditions, likelihood, impact and risk (NIST 2012).

### 2.1 Prepare for the assessment

| NIST preparation element | Application to this project |
|---|---|
| Purpose | Support security decisions and successful delivery of an integrated cyber-resilience prototype. |
| Scope | APP01, MON01, BKP01, pfSense, switch/VLAN connectivity and team-delivery activities. |
| Assumptions | The environment is a controlled educational lab; test data are representative rather than real customer data; ratings reflect available evidence. |
| Constraints | Limited time, different team laptops, physical-switch dependence, self-signed certificates, and incomplete end-to-end testing. |
| Information sources | GitHub evidence, configuration files, screenshots, service output, Wazuh alerts, backup logs, firewall tests and team demonstrations. |
| Risk model | Likelihood (1-5) multiplied by impact (1-5), followed by a qualitative risk rating. |

### 2.2 Likelihood scale

| Score | Rating | Meaning in this project |
|---:|---|---|
| 1 | Rare | The event is highly unlikely during the project and requires unusual conditions. |
| 2 | Unlikely | The event could occur, but working controls and limited exposure make it improbable. |
| 3 | Possible | The event may occur because exposure or an incomplete control exists. |
| 4 | Likely | The event has already been observed, is easy to reproduce, or an important control is unverified. |
| 5 | Almost certain | The event is currently occurring or is expected repeatedly without immediate treatment. |

### 2.3 Impact scale

| Score | Rating | Meaning in this project |
|---:|---|---|
| 1 | Insignificant | Negligible disruption and no meaningful loss of confidentiality, integrity or availability. |
| 2 | Minor | Small local disruption that can be corrected quickly without affecting project acceptance. |
| 3 | Moderate | Noticeable service or evidence gap requiring team effort and retesting. |
| 4 | Major | Loss of an important security outcome, significant data exposure, or failure of a project objective. |
| 5 | Severe | Loss of critical data or recovery capability, broad compromise, unsafe testing, or failure of the overall project. |

### 2.4 Risk determination

**Risk score = likelihood x impact**

| Score | Rating | Required response |
|---:|---|---|
| 1-4 | Low | Accept or monitor through routine review. |
| 5-9 | Moderate | Assign an owner and complete proportionate treatment. |
| 10-16 | High | Prioritise treatment and obtain evidence before final acceptance. |
| 17-25 | Extreme | Treat as a critical-path issue; do not claim the affected outcome is complete. |

The **inherent risk** is the estimated exposure without the controls implemented by the team. The **residual risk** is the current exposure after considering controls that are implemented and supported by evidence. These scores are decision aids rather than precise measurements.

## 3. Asset assessment

The example template assesses assets according to confidentiality, integrity and availability. The same approach is applied here using a 1-5 scale. A higher total indicates that compromise of the asset would create greater harm.

| Asset | Confidentiality | Integrity | Availability | Total | Importance |
|---|---:|---:|---:|---:|---|
| Nextcloud business data and database | 5 | 5 | 5 | 15 | Critical |
| Backup repository and recovery points | 5 | 5 | 5 | 15 | Critical |
| Administrative credentials, MFA secrets and recovery codes | 5 | 5 | 4 | 14 | Critical |
| Encryption keys, Restic password and MinIO secrets | 5 | 5 | 4 | 14 | Critical |
| pfSense configuration, VLANs and firewall rules | 4 | 5 | 5 | 14 | Critical |
| Wazuh alerts, audit logs and monitoring configuration | 4 | 5 | 5 | 14 | Critical |
| APP01 application and database services | 4 | 5 | 5 | 14 | Critical |
| BKP01 MinIO and Restic services | 4 | 5 | 5 | 14 | Critical |
| MON01 Wazuh platform | 4 | 5 | 4 | 13 | High |
| TLS certificates and private keys | 5 | 5 | 3 | 13 | High |
| GitHub repository and assessment evidence | 4 | 5 | 3 | 12 | High |
| Physical switch, cabling and host adapters | 2 | 4 | 5 | 11 | High |
| VirtualBox VMs and snapshots | 3 | 4 | 4 | 11 | High |

The highest-priority assets are the primary Nextcloud data, usable recovery points, privileged credentials and security configurations. Failure of these assets could defeat both normal business operation and recovery after an incident.

## 4. Threat assessment

NIST recognises adversarial, accidental, structural and environmental threat sources (NIST 2012). All four categories are relevant to this project.

| Threat source | Example threat event | Main targets |
|---|---|---|
| External attacker | Brute-force login, credential attack, malware, exploitation of an unpatched service or unauthorised access to exposed storage | Nextcloud, SSH, Wazuh agents and MinIO |
| Malicious insider or compromised user | Altering source data and backups, excessive access, theft of credentials or deletion of evidence | Nextcloud data, MinIO backups and repository |
| Accidental user or administrator action | Incorrect VLAN, firewall rule, permission, hardening setting, deletion or disclosure of a secret | pfSense, VMs, GitHub and configuration files |
| Structural or technology failure | VM crash, service failure, disk corruption, cron failure, broken dependency or network-adapter failure | APP01, MON01, BKP01 and switch connectivity |
| Environmental or physical event | Laptop loss, power loss, cable disconnection or switch failure | All locally hosted components |
| Project and process failure | Delayed integration, unclear ownership, incomplete evidence or unsafe simulation | Assessment acceptance and the integrated solution |

## 5. Existing control position

| Workstream | Demonstrated controls and progress | Important remaining gap |
|---|---|---|
| APP01 - Nextcloud and identity | Ubuntu, Apache, PHP, MariaDB and Nextcloud installed; database hardening; data located outside the web root; caching and Redis file locking; HTTPS/HSTS; groups, Team Folders and quotas; administrator TOTP. | Production VLAN operation, negative authorisation tests, MFA recovery, certificate trust and end-to-end backup still require final evidence. |
| Network - pfSense and VLANs | pfSense and VLANs 10/20/30/40/99 configured; aliases, addressing and initial least-privilege rules documented; several gateways reachable. | MON01 at 10.20.30.10 could not reach 10.20.30.1 while other gateways responded. Approved and denied traffic paths have not been comprehensively demonstrated. |
| MON01 - Wazuh and hardening | Agent 001 active; 12 authentication failures detected; FIM add/modify/delete events verified; high vulnerability findings reduced from 8 to 6; CIS SCA improved from 45% to 49%, with passed checks increasing from 82 to 89. | APP01 and BKP01 events are not yet confirmed centrally. Remaining vulnerabilities, pending evaluations and failed CIS checks require risk-based review. |
| BKP01 - MinIO and Restic | Encrypted repository, automated script, integrity check, deliberate failure handling, four-hour schedule, MinIO automatic start, retention, restricted-user denial and VLAN 40 addressing demonstrated. | Backup of representative Nextcloud data over the final network, Wazuh log ingestion, isolation from ordinary users, and a timed end-to-end restore remain pending. |
| Team delivery | Named responsibilities, repository evidence, staged work and team coordination exist. | Integration dependencies and acceptance tests remain concentrated near the end of the project. |

## 6. Risk register

### 6.1 Integration and operational-resilience risks

| ID | Threat event and affected asset | Vulnerability or predisposing condition | Inherent L x I | Existing controls/evidence | Residual L x I | Status | Required treatment and owner |
|---|---|---|---:|---|---:|---|---|
| R-01 | Network traffic cannot reach MON01 or cross the required VLAN paths; monitoring, backup and recovery fail. | Incorrect switch port, VLAN tagging, subinterface, gateway, route or interface assignment. MON01 could reach other gateways but not 10.20.30.1. | 4 x 5 = **20 Extreme** | VLAN/IP plan, pfSense interfaces and rules; some gateway tests succeeded. | 4 x 5 = **20 Extreme** | Open - critical | **Network owner and all system owners:** verify cable/switch ports, access or trunk mode, VLAN 30 tagging, pfSense interface, ARP and routes. Record approved APP01-BKP01-MON01 connectivity. |
| R-02 | Firewall permits unauthorised access or blocks required business traffic. | Rules or aliases may be too broad, too restrictive or insufficiently tested. | 3 x 5 = **15 High** | Separate VLANs, aliases and final-deny approach documented. | 3 x 4 = **12 High** | Partially treated | **Network owner:** approve a traffic matrix, test every allowed and denied path, and retain pfSense rule and log evidence. |
| R-03 | A backup completes but representative Nextcloud business data cannot be restored accurately. | Tests have used sample data; the complete application/database restore and integrity comparison are incomplete. | 4 x 5 = **20 Extreme** | Restic repository, sample backup/restore, integrity check and meaningful exit codes demonstrated. | 3 x 5 = **15 High** | Partially treated | **BKP01 and APP01 owners:** back up representative files and database material, restore to a clean location, compare counts and SHA-256 hashes, and record RTO/RPO. |
| R-04 | The four-hour recovery-point objective is missed after reboot or service failure. | Cron, environment variables, mounts, network dependencies or MinIO service may fail silently. | 3 x 4 = **12 High** | Four-hour cron, restricted-environment test, MinIO service and reboot persistence demonstrated. | 2 x 4 = **8 Moderate** | Monitor | **BKP01 owner:** capture successful recovery points over several cycles and send backup success/failure events to Wazuh. |
| R-05 | A compromised office user changes or deletes both the source data and its backups. | Backup storage may be reachable from unnecessary VLANs; immutability and administrative separation are not fully proven. | 4 x 5 = **20 Extreme** | Restricted MinIO user denied access; secrets file protected; retention configured; BKP01 separated on VLAN 40. | 3 x 5 = **15 High** | Partially treated | **BKP01 and network owners:** limit API/console sources, deny office-user access, separate backup credentials, test authorised and denied paths, and preserve protected recovery points. |
| R-06 | APP01 or BKP01 attacks and failures are not detected centrally. | Unique Wazuh agents and required application/backup log paths are not yet fully integrated. | 4 x 4 = **16 High** | MON01 detects local authentication and FIM events; APP01 and BKP01 produce relevant logs. | 4 x 4 = **16 High** | Open - critical | **MON01, APP01 and BKP01 owners:** enrol unique agents, ingest required logs, trigger controlled success/failure events, and verify host, timestamp, rule, status and severity. |
| R-07 | Alert noise or duplicate events hide important incidents. | No mature baseline or documented tuning threshold exists. | 3 x 3 = **9 Moderate** | Controlled tests can be compared with source logs; monitoring scope remains limited. | 2 x 3 = **6 Moderate** | Ongoing | **MON01 owner:** establish normal event volume, tune duplicate/noisy rules and keep successful routine events at lower severity. |

### 6.2 Security and information-protection risks

| ID | Threat event and affected asset | Vulnerability or predisposing condition | Inherent L x I | Existing controls/evidence | Residual L x I | Status | Required treatment and owner |
|---|---|---|---:|---|---:|---|---|
| R-08 | An attacker exploits a known package vulnerability, or remediation breaks a dependency. | Older packages and mixed package sources exist; vulnerability results include remaining high findings. | 4 x 4 = **16 High** | Snapshot and package inventory captured; jupyter-core remediated; high findings reduced from 8 to 6. | 3 x 4 = **12 High** | Partially treated | **MON01 owner:** validate exposure, remediate incrementally, test dependent services, rescan, and document justified exceptions. |
| R-09 | CIS hardening disables a required filesystem, module or service. | Generic benchmark controls may not match the Kali lab workload. | 3 x 4 = **12 High** | Module-use and mount checks, incremental changes and rollback snapshot; SCA improved from 45% to 49%. | 2 x 3 = **6 Moderate** | Controlled | **MON01 owner:** apply only applicable controls, record check IDs and commands, test services after each batch, and treat the score as evidence of improvement rather than complete compliance. |
| R-10 | A user bypasses Nextcloud role restrictions or MFA, or the administrator is locked out. | Negative permission tests, MFA-recovery workflow and secondary administration remain incomplete. | 3 x 5 = **15 High** | Groups, Team Folders, quotas, administrator TOTP, least-privilege database access and Redis locking. | 2 x 4 = **8 Moderate** | Partially treated | **APP01 owner:** test prohibited folder access, password-only failure, MFA success, backup-code recovery and secondary authorised administration. |
| R-11 | Users accept the wrong server because of self-signed-certificate warnings. | The lab certificate is not automatically trusted and users may ignore browser warnings. | 3 x 4 = **12 High** | HTTPS redirection, HSTS and a strong self-signed lab certificate. | 3 x 3 = **9 Moderate** | Accepted for lab | **APP01 owner:** record the limitation, verify fingerprints through an approved channel and use a trusted CA in a production-like deployment. |
| R-12 | Credentials, private keys, IP details or personal data are disclosed through GitHub or screenshots. | Evidence collection can unintentionally capture secrets; repository history preserves deleted material. | 3 x 5 = **15 High** | Backup environment file excluded from Git and permission restricted; sanitisation requirement identified. | 2 x 5 = **10 High** | Ongoing | **All members:** scan repository history and exports, redact secrets and personal information, use synthetic data, rotate any exposed credential and never commit private keys. |

### 6.3 Safety and project-delivery risks

| ID | Threat event and affected asset | Vulnerability or predisposing condition | Inherent L x I | Existing controls/evidence | Residual L x I | Status | Required treatment and owner |
|---|---|---|---:|---|---:|---|---|
| R-13 | A controlled data-loss simulation deletes real data or damages the only valid backup. | Destructive commands may be run against an incorrect path or before a recovery point is verified. | 3 x 5 = **15 High** | Planned use of designated test data, confirmed snapshot, no malware and exclusion of MinIO. | 1 x 5 = **5 Moderate** | Planned | **Whole team:** obtain approval, use an allow-listed disposable path, verify the recovery point, rehearse safely, notify members and stop if the target is uncertain. |
| R-14 | Integration delays or weak evidence prevent minimum viable product and assessment acceptance. | Workstreams depend on the shared switch and firewall; end-to-end testing remains incomplete. | 4 x 4 = **16 High** | Named responsibilities, weekly coordination, repository evidence and staged plan. | 3 x 4 = **12 High** | Open | **Project team:** complete tasks in dependency order, assign dates and evidence owners, review blockers daily during integration, and update the register after each acceptance test. |

## 7. Recommended controls and treatment plan

The template groups controls as preventive, detective, compensating and corrective. That model is applied below so that the project does not rely on only one type of protection.

### 7.1 Preventive controls

- Approve a least-privilege network traffic matrix before adding further pfSense rules.
- Separate application, monitoring, backup, user and management traffic through the planned VLANs.
- Restrict MinIO API and console access to approved source systems and administrative hosts.
- Use separate credentials for Nextcloud, backup automation, MinIO administration and monitoring.
- Retain MFA for privileged Nextcloud accounts and test recovery codes securely.
- Apply security patches incrementally after checking package ownership and dependencies.
- Apply CIS controls only when they are suitable for the system's function.
- Keep secrets outside Git, restrict file permissions and use representative synthetic data in screenshots.

### 7.2 Detective controls

- Enrol APP01 and BKP01 as unique Wazuh agents.
- Collect authentication, Nextcloud, web-server and JSON backup logs.
- Alert separately for backup success and failure, with failure assigned the higher severity.
- Continue Wazuh FIM for important application, configuration and backup-script paths.
- Monitor vulnerability findings and CIS SCA changes after remediation.
- Enable and retain pfSense logs for blocked inter-VLAN connections.
- Alert when a scheduled backup is late or absent, not only when a script reports failure.

### 7.3 Compensating controls

- Preserve VirtualBox snapshots before high-risk package or hardening changes.
- Maintain protected recovery points while stronger immutability is being tested.
- Isolate a suspected system or block its source address when compromise is detected.
- Retain manual restore instructions if automated recovery fails.
- Verify self-signed certificate fingerprints through a separate trusted communication channel.

### 7.4 Corrective and recovery controls

- Restore representative Nextcloud data and its database into a clean target.
- Compare restored file counts and hashes with the protected source set.
- Record recovery start time, completion time, latest usable recovery point, RTO and RPO.
- Rebuild a compromised VM from a trusted snapshot or clean image and rotate affected credentials.
- Review Wazuh and pfSense evidence after an incident to determine scope and required control changes.

### 7.5 Priority order

1. **Restore MON01 network reachability (R-01).** Validate the physical switch port, VLAN 30 configuration, pfSense interface, ARP response and routing.
2. **Approve and test the firewall traffic matrix (R-02 and R-05).** Demonstrate both permitted and denied paths.
3. **Complete central monitoring (R-06).** Connect APP01 and BKP01 to MON01 and reproduce controlled security and backup events.
4. **Demonstrate real-data backup and recovery (R-03 and R-04).** Measure integrity, RTO and RPO.
5. **Close high residual security risks (R-08 and R-12).** Continue vulnerability treatment and inspect the evidence repository for sensitive information.
6. **Run the controlled resilience simulation (R-13).** Proceed only after the network, backup and safety prerequisites pass.
7. **Assemble the final acceptance evidence (R-14).** Link each requirement to a configuration and a repeatable test result.

## 8. Risk communication and acceptance

NIST SP 800-30 requires assessment results to be communicated so that decision makers can select appropriate responses (NIST 2012). The team should review this register during each project meeting. Every High or Extreme residual risk must have a named owner, a target date and a required evidence item.

The following acceptance gates should be used:

| Gate | Acceptance evidence |
|---|---|
| Network | Successful gateway and service-port tests plus pfSense logs for at least one deliberately denied path. |
| Monitoring | APP01 and BKP01 visible as unique agents; controlled authentication, FIM and backup events searchable on MON01. |
| Backup isolation | APP01 backup is permitted, ordinary office access is denied, and administrative access is restricted. |
| Recovery | Representative application data and database restored with integrity checks and documented RTO/RPO. |
| Identity | Authorised access succeeds; prohibited folder access and password-only privileged access fail; MFA recovery succeeds. |
| Evidence safety | Repository checked for secrets and personal data; exposed credentials rotated if required. |

Risk acceptance should be explicit. A Moderate risk may be accepted for the educational lab when the limitation, justification and monitoring action are documented. A High or Extreme residual risk affecting the core resilience claim should not be accepted without treatment or formal approval from the project supervisor.

## 9. Maintaining the assessment

Risk assessment is an ongoing activity rather than a one-time document (NIST 2012). The register must be updated:

- after the VLAN 30 connectivity issue is resolved;
- after APP01 and BKP01 are enrolled in Wazuh;
- after each firewall allow/deny test;
- after a vulnerability or CIS remediation batch;
- after the first end-to-end backup and timed restore;
- after changes to credentials, certificates, VLANs, rules or backup schedules; and
- when new evidence changes the likelihood, impact or effectiveness of a control.

For each update, the team should retain the review date, reviewer, evidence link, rating change and reason for the change. This maintains traceability and prevents risk scores from being reduced without proof.

## 10. Overall conclusion

The project has progressed beyond initial design. APP01, MON01 and BKP01 each demonstrate useful local security and resilience controls, while pfSense provides the foundation for segmented communication. Wazuh has detected failed authentication and file-integrity events; vulnerability remediation and CIS hardening have produced measurable improvement; Nextcloud includes access-control and MFA features; and the backup workstream includes encrypted storage, scheduled execution, integrity checking and deliberate failure handling.

Nevertheless, the project's overall residual risk remains **High**. The principal reason is that the security outcome depends on a chain of connected controls. Business data must be protected on APP01, transmitted only through approved network paths, monitored by MON01, backed up to an isolated BKP01 repository and restored within the recovery objectives. At present, the failure of VLAN 30 connectivity and incomplete end-to-end tests prevent the team from demonstrating this full chain.

The project can reduce its overall risk to Moderate by resolving network integration, proving least-privilege firewall behaviour, centralising logs, completing an integrity-checked restore, and documenting all acceptance evidence. The risk register should then be reassessed rather than automatically lowering scores after configuration changes.

## References


National Institute of Standards and Technology (NIST) 2012, *Guide for conducting risk assessments*, Special Publication 800-30 Revision 1, US Department of Commerce, Gaithersburg, MD, viewed 5 September 2026, <https://doi.org/10.6028/NIST.SP.800-30r1>.

