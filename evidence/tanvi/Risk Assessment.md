# 11. Risk identification and mitigation plan

The risk register is treated as a working project control rather than a one-time document. Risks are assessed using likelihood (L) and impact (I) values from 1 (low) to 5 (very high), with the initial score calculated as L × I. This approach supports prioritisation and regular review, consistent with NIST guidance that risk assessment should consider threats, vulnerabilities, likelihood and impact and should inform risk responses (NIST 2012).

The register below has been updated to reflect the current project position. MON01 has been implemented in VirtualBox, the Wazuh agent is active, authentication failures and file changes have been detected, vulnerability scanning has been demonstrated, and selected CIS configuration weaknesses have been remediated. Network integration with APP01, BKP01 and pfSense, together with end-to-end backup and restore testing, remains incomplete.

| ID | Current risk | L | I | Initial rating | Current treatment and evidence | Owner/status |
|---|---|---:|---:|---|---|---|
| R-01 | The three project systems cannot communicate because they are on different subnets or incorrectly attached VirtualBox networks. | 4 | 5 | 20 Extreme | The agreed addresses are APP01 `10.20.20.10/24`, MON01 `10.20.30.10/24` and BKP01 `10.20.40.10/24`. pfSense must provide routing through `.1` gateway interfaces and explicit firewall rules. MON01 has been configured with `10.20.30.10/24`, but end-to-end routing is still being tested. | Team — open, highest priority |
| R-02 | Wazuh loses visibility because the MON01 agent disconnects or its address changes. | 3 | 5 | 15 High | Agent 001 (`KALI-ENDPOINT`) has been confirmed active. The team will retain stable addressing, check agent status before demonstrations and document any address change. | Tanvi — controlled and monitored |
| R-03 | Authentication attacks occur but no useful alert is generated. | 3 | 4 | 12 High | Controlled SSH attempts using `invaliduser` generated 12 authentication-failure alerts from `192.168.56.10`. The event view and source logs provide verification evidence. | Tanvi — treatment tested |
| R-04 | Important file changes are not detected or FIM creates excessive noise. | 3 | 4 | 12 High | Wazuh FIM was tested on `/home/vagrant/fim-test/test-file.txt`. Creation, modification and deletion produced rules 554, 550 and 553. Monitoring paths and exclusions will be limited to security-relevant locations. Wazuh documents these rules for file-added, checksum-changed and file-deleted events (Wazuh 2026a). | Tanvi — treatment tested; tuning ongoing |
| R-05 | Vulnerable software remains installed or remediation breaks the endpoint. | 4 | 4 | 16 Extreme | A VirtualBox snapshot and Python package inventory were created before remediation. `jupyter-core` was upgraded from 4.10.0 to 4.11.2 and Wazuh high-severity findings decreased from 8 to 6. Remaining findings must be investigated individually rather than changed in bulk. Wazuh vulnerability detection uses endpoint inventory to identify affected software (Wazuh 2026b). | Tanvi — partially treated |
| R-06 | CIS hardening changes disable a required filesystem or service. | 3 | 4 | 12 High | Changes were made incrementally after checking whether each filesystem was loaded or mounted. The VM snapshot provides a rollback point. Selected unused filesystem modules were disabled and rescanned. Oracle states that a VirtualBox snapshot can preserve a VM state for later restoration (Oracle 2024). | Tanvi — partially treated |
| R-07 | The CIS score is mistaken for complete security compliance. | 3 | 4 | 12 High | The CIS Distribution Independent Linux Benchmark result improved from 45% (82 passed, 99 failed) to 49% (89 passed, 92 failed). The remaining 92 failures require risk-based review. Wazuh SCA evaluates endpoint settings against policy checks; it does not by itself prove that all operational risks are controlled (Wazuh 2026c). | Tanvi — open |
| R-08 | Backup jobs report success but the data cannot be restored. | 4 | 5 | 20 Extreme | BKP01 logs will use a consistent format and be collected by Wazuh. Success and failure should generate separate events, but acceptance requires a sample restore, integrity check and timed recovery test. | Mahfuz and team — open |
| R-09 | Ransomware or stolen credentials delete both primary data and reachable backups. | 4 | 5 | 20 Extreme | Keep BKP01 on a separate network, use a restricted backup account, enable retention/versioning where supported and test an independent copy. Firewall access should be limited to required sources, destinations and ports. | Mahfuz and team — open |
| R-10 | Unsafe testing damages non-test data or the VM. | 2 | 5 | 10 High | Use synthetic data, an allow-listed test directory, snapshots and reversible tests. Real ransomware and uncontrolled destructive testing are excluded. | All members — controlled |
| R-11 | Secrets, personal information or identifying data are exposed in GitHub or the submitted report. | 3 | 5 | 15 High | Use synthetic records, keep the repository private, exclude credentials, and review screenshots/configuration before committing or submitting them. | All members — open control |
| R-12 | Integration delays or uneven contribution prevent completion of the minimum viable product (MVP). | 4 | 4 | 16 Extreme | Keep one owner for each workstream, show weekly evidence, record blockers and prioritise MON01–APP01–BKP01 connectivity, Wazuh log collection, backup and restore before stretch goals. | Team — open |

At this stage, the most urgent risks are network integration (R-01), backup restorability (R-08), backup isolation (R-09) and completion of the MVP (R-12). The risk register will be reviewed at each weekly meeting, and evidence will be added when a treatment has been tested successfully.

# 12. Quality management plan

Quality is measured by repeatable test results and evidence, not by installation alone. Each important configuration must be connected to a requirement, tested against an expected result and supported by a screenshot, command output, log or repository record. This approach directly supports the assessment requirement for clear, verifiable evidence and measurable individual progress (CQUniversity 2026).

| Quality area | Current quality control | Evidence/acceptance criterion | Current result |
|---|---|---|---|
| Requirements traceability | Link each allocated task to its implementation, test and evidence identifier. | Traceability table contains no unsupported “completed” claims. | In progress |
| Wazuh availability | Confirm that agent 001 is active and sending events before each test. | Dashboard displays `KALI-ENDPOINT`, agent ID 001, status Active. | Passed |
| Authentication monitoring | Generate controlled invalid SSH activity and compare the source log with Wazuh. | Source IP, username, event time and authentication-failure alert are visible. | Passed: 12 failures detected |
| File integrity monitoring | Create, modify and delete a harmless test file in the monitored directory. | Wazuh shows added (554), modified (550) and deleted (553) events for the same path. | Passed |
| Vulnerability management | Record the finding, confirm the package source/version, take a snapshot, make one controlled change and rescan. | Before/after versions and vulnerability counts are captured; core services continue operating. | Partially passed: high findings reduced 8 → 6 |
| CIS hardening | Check operational need before each change, apply one small group of controls and rescan. | Before/after SCA totals and the affected check IDs are recorded. | Passed for selected controls: score 45% → 49% |
| Network integration | Verify interface, address, route and firewall path rather than relying on a single ping. | APP01 and BKP01 reach MON01 through the intended switch/pfSense path; the route uses the correct interface. | Not yet accepted |
| Backup monitoring | Produce structured success and failure messages from the backup script and collect them in Wazuh. | Separate searchable alerts identify timestamp, host, job, status and useful error detail. | Planned/integration pending |
| Recovery | Restore a known data set and compare content or hashes; record elapsed time. | Restore succeeds and measured RPO/RTO meet the agreed project target. | Not yet tested |
| Reproducibility | Store commands, configurations, versions and rollback instructions in the private repository. | Another team member can repeat the procedure using the runbook. | In progress |
| Documentation | Use consistent system names, numbered evidence, captions, Harvard citations and proofreading. | A peer verifies that every technical claim is supported and terminology is consistent. | In progress |

The current results demonstrate measurable improvement, but the project will not be declared complete until the cross-system network path, backup-alert integration and restoration test pass. This distinction prevents dashboard activity from being treated as proof of end-to-end resilience.

# 13. Tools, technologies and resources

The current implementation has been narrowed to the tools actually used or assigned in the project. Removing unconfirmed alternatives makes the design easier to reproduce and clearly distinguishes the working MON01 environment from planned integration components.

| Tool/resource | Current project use | Selection rationale and limitation | Current state |
|---|---|---|---|
| Oracle VirtualBox | Hosts the Kali Linux MON01 laboratory VM and provides rollback snapshots before risky changes. | Suitable for the available student hardware. Snapshots support rollback but are not a replacement for an independent data backup (Oracle 2024). | Implemented |
| Kali Linux (MON01) | Runs the monitored endpoint and the Wazuh laboratory interface used for testing. | Provides the Linux environment required for log, package, FIM and hardening tests. The observed system is an older Kali release and therefore requires careful compatibility checks. | Implemented |
| Wazuh | Provides endpoint status, threat hunting, authentication alerts, FIM, vulnerability detection and SCA. | One platform supplies several types of security evidence. Its output still requires human validation and safe remediation. | Implemented and tested |
| Wazuh FIM | Monitors selected files and directories for creation, modification and deletion. | Wazuh describes FIM as monitoring file integrity and detecting changes to selected paths (Wazuh 2026a). Broad paths may generate unnecessary alerts. | Test passed |
| Wazuh Vulnerability Detection | Correlates software inventory with known vulnerability information. | Supports prioritised remediation; findings must be checked against the actual package source and version (Wazuh 2026b). | Tested; remediation ongoing |
| Wazuh Security Configuration Assessment | Runs the CIS Distribution Independent Linux Benchmark checks. | Identifies configuration weaknesses and shows measurable before/after results. Wazuh states that SCA uses policy files to test endpoint configuration (Wazuh 2026c). | Tested; 49% score |
| pfSense | Intended to route and filter traffic between the APP01, MON01 and BKP01 networks. | pfSense supports VLAN interfaces and firewall rules, but the addressing, switch configuration and rule set must match on all laptops (Netgate 2025a; Netgate 2025b). | Integration in progress |
| Physical/managed switch and Ethernet adapters | Provides the link between team laptops and the pfSense network. | Required for the planned separated subnets. A basic Layer 2 switch cannot route between `10.20.20.0/24`, `10.20.30.0/24` and `10.20.40.0/24`; routing must be supplied by pfSense. | Integration in progress |
| Nextcloud (APP01) | Stores the representative application data to be protected and monitored. | Provides the application workload for authentication, file and recovery testing. | Owned by Sourabh; team integration pending |
| MinIO (BKP01) | Provides the S3-compatible backup target. | Supports an isolated backup workstream, but resilience must be demonstrated by an actual restore. | Owned by Mahfuz; team integration pending |
| Backup script and logs | Runs backup/verification tasks and emits messages for Wazuh collection. | Automation improves repeatability. A proposed one-line format is `timestamp host job status duration details`; separate success and failure alerts make testing clearer. | Log contract being coordinated |
| GitHub private repository | Stores approved configurations, scripts, diagrams, test records and the AI-use log. | Gives timestamped evidence and enables review. Secrets and personal data must not be committed. | In use/in progress |
| Microsoft Teams/weekly meetings | Records decisions, task allocation, blockers and mentor feedback. | Supports professional communication and evidence of engagement. | In use |

## 13.1 Current resource and budget position

| Item | Current provision | Expected direct cost | Control |
|---|---|---:|---|
| Student laptops and existing virtualisation resources | Team-provided | AU$0 | Monitor CPU, memory and storage; start VMs in stages if required. |
| Wazuh, Kali Linux, pfSense, Nextcloud and MinIO community software | Used for the academic MVP | AU$0 licence purchase currently identified | Confirm licence conditions and document the exact versions used. |
| Physical switch and Ethernet cables/adapters | Existing/team-provided where available | To be confirmed | Confirm port/VLAN capability before relying on segmented subnets. |
| Optional cloud/off-site storage | Stretch goal only | Not yet approved | Do not purchase or deploy until the MVP works and the team approves a capped amount. |
| Additional storage | Only if test data exceeds available capacity | Not yet required | Approval is required before purchase; synthetic data only. |

No unsupported dollar amount is claimed at this stage. The minimum viable build is economically feasible with existing equipment and community software, while any optional cloud cost remains outside the confirmed baseline.

# 14. Feasibility analysis

The project is feasible, but current evidence shows that feasibility depends on completing network integration and end-to-end recovery testing. The analysis below is therefore based on demonstrated results rather than tool availability alone.

| Dimension | Current assessment | Evidence and remaining condition |
|---|---|---|
| Technical feasibility | Feasible with integration risk. | MON01 runs successfully in VirtualBox; Wazuh agent 001 is active; authentication, FIM, vulnerability and SCA functions have been demonstrated. The unresolved condition is routed communication among APP01, MON01 and BKP01 through the intended pfSense/switch topology. |
| Schedule feasibility | Feasible if the team protects the MVP scope. | Tanvi’s monitoring tasks have moved beyond installation into tested alerts and remediation. The next priority must be connectivity, backup log ingestion and restore testing. Optional cloud replication and advanced tuning should wait. |
| Operational feasibility | Feasible for a small lab with short runbooks. | The Wazuh dashboard makes agent status and alerts visible. Repeatability still depends on documenting commands, evidence labels, recovery steps and ownership. |
| Security feasibility | Partly demonstrated. | Failed-login detection, FIM, vulnerability detection and CIS SCA are operational. Segmentation, least-privilege firewall rules, backup isolation and full hardening are not yet fully verified. |
| Recovery feasibility | Not yet proven. | The planned Nextcloud-to-MinIO path is reasonable, but a successful backup alert is not enough. A controlled restore, integrity comparison and elapsed-time measurement are required. |
| Economic feasibility | Feasible within the current baseline. | Existing laptops and community software have avoided a confirmed direct software cost. Optional cloud storage remains a stretch goal subject to approval. |
| Safety and ethical feasibility | Feasible under the stated controls. | Testing uses synthetic data, harmless invalid-login attempts, a dedicated FIM test file, snapshots and controlled configuration changes. Real malware/ransomware and unauthorised testing are excluded. |
| Team feasibility | Feasible with clear interfaces between workstreams. | Tanvi owns MON01/Wazuh, Sourabh owns APP01/Nextcloud and Mahfuz owns BKP01/MinIO. The remaining dependency is an agreed network and log format that allows the independently built components to operate together. |

Overall, the project has progressed from a proposed architecture to a working monitoring prototype. The strongest evidence is the active agent, 12 authentication-failure alerts, the complete FIM create/modify/delete sequence, the reduction of high-severity vulnerability findings from 8 to 6, and the CIS improvement from 45% to 49%. The project will become fully feasible as a cyber-resilience solution only when the three systems communicate through the intended network and a monitored backup can be restored successfully.

# 15. Professional, ethical and security considerations

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
