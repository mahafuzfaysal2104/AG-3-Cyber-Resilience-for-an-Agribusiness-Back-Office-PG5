# 11. Risk identification and mitigation

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
