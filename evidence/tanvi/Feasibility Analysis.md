
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
