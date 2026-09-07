
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
