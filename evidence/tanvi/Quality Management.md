# 12. Quality management  

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
