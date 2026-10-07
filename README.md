
# AG3 — Cyber Resilience for an Agribusiness Back Office

**COIT20265 — Networks and Information Security Project | Group PG5 | CQUniversity Australia**

**Project Mentor:** Dr Fariza Sabrina

## Project Overview

AG3 focuses on improving cybersecurity and data recovery for Plains Pastoral Co., a small agribusiness. The project combines network segmentation, secure file access, security monitoring and encrypted backups to protect business information.

A working prototype was developed using **pfSense, Nextcloud, Wazuh, Restic and MinIO**. The team tested firewall rules, role-based access, multi-factor authentication, security alerts, backup operations and recovery from simulated ransomware-like file damage.

The prototype demonstrates selected security and recovery capabilities in a controlled environment. It is not a production-ready system.

---

## Team Members

| Team Member | Student ID | Workstream |
|---|---|---|
| **Akib Hossain** | 12304711 | Network design, pfSense configuration, VLAN segmentation, firewall rules and connectivity testing |
| **Ashraful Abedin Shourab** | 12298592 | Nextcloud implementation, user authentication, role-based access control and application recovery |
| **Sheikh Tanvi Mahmud** | 12297656 | Wazuh deployment, security monitoring, file integrity monitoring and security testing |
| **Md Mahafuz Faysal** | 12281612 | MinIO backup server, Restic integration, automated backups and repository management |

---

## Technical Artefacts

The following documents contain the technical designs, implementation procedures, testing evidence and risk assessments completed during the project.

| Technical Document | Description | Link |
|---|---|---|
| **AG3 Detailed Network Design** | Network alternatives, selected architecture, VLANs, IP addressing and hardware recommendations | ([AG3 Detailed Network Design](Technical%20Artifact/PG5%20AG3%20TA1%20Detailed%20Network%20Design.docx)) |
| **AG3 Firewall, Segmentation and Access Control Design** | pfSense firewall policies, VLAN communication rules, Nextcloud access controls and firewall testing | ([AG3 Firewall, Segmentation and Access Control Design](Technical%20Artifact/PG5%20AG3%20TA2%20Firewall,%20Segmentation%20and%20Access%20Control%20Design.docx)) |
| **AG3 Prototype Implementation Plan and Guide** | Implementation steps, system configuration, integration and troubleshooting | ([AG3 Prototype Implementation Plan and Guide](Technical%20Artifact/PG5%20AG3%20TA3%20Prototype%20Implementation%20Plan%20and%20Guide.docx)) |
| **AG3 Security Monitoring and Wazuh Implementation** | Wazuh simulation, MON01 deployment, APP01 agent integration and monitoring results | ([AG3 Security Monitoring and Wazuh Implementation](Technical%20Artifact/PG5%20AG3%20TA4%20Security%20Monitoring%20and%20Wazuh%20Implementation.docx)) |
| **AG3 Prototype Testing and Validation Report** | Prototype screenshots, firewall validation, security monitoring, backup testing and controlled recovery evidence | ([AG3 Prototype Testing and Validation Report](Technical%20Artifact/PG5%20AG3%20TA5%20Prototype%20Testing%20and%20Validation%20Report.docx)) |
| **AG3 Risk Assessment Report** | Security risks, vulnerabilities, existing controls, residual risks and recommended treatments ([AG3 Risk Assessment Report](Technical%20Artifact/PG5%20AG3%20TA6%20Risk%20Assessment%20Report.docx)) |
| **AG3 Risk Assessment Register** | Risk ratings, likelihood, impact, responsible owners and mitigation actions | ([AG3 Risk Assessment Register](Technical%20Artifact/PG5%20AG3%20TA7%20Risk%20Assessment%20Register.xlsx)) |
| **AG3 Cyber Resilience Incident Recovery Plan** | Incident response procedures, containment, evidence preservation and service recovery planning | ([Cyber Resilience Incident Recovery Plan](Technical%20Artifact/PG5%20AG3%20TA8%20Cyber%20Resilience%20and%20Incident%20Recovery.docx)) |

---

## Prototype Demonstration Videos

The following videos provide visual evidence of the implemented prototype and selected security tests.

| Video | Demonstration | Link |
|---|---|---|
| **V01** | Overall prototype and physical setup | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1790614893162?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1790614893162&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1790614893162&ngc=true) |
| **V02** | Secure Nextcloud file access and administrator MFA | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1791341426444?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1791341426444&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1791341426444&ngc=true) |
| **V03** | Wazuh File Integrity Monitoring | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1791341892186?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1791341892186&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1791341892186&ngc=true) |
| **V04** | Wazuh monitoring of successful and failed backup operations | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1790615165443?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1790615165443&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1790615165443&ngc=true) |
| **V05** | Encrypted Restic backup storage on MinIO | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1790615585192?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1790615585192&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1790615585192&ngc=true) |
| **V06** | Controlled ransomware-like file impact, detection and recovery | [Watch Video](https://teams.microsoft.com/l/message/19:yY-SA7HrltiJoTRIm3Mb-aOPHynfmpdIcng0hTn4Vos1@thread.tacv2/1791342186190?tenantId=fdade0c4-3fea-4320-ae53-1a1742aeff1e&groupId=72cb473b-43f8-406a-a3fa-ebab5c707408&parentMessageId=1791342186190&teamName=COIT20265%3A%20Networks%20and%20Information%20Security%20Project%20(HT2%2C%202026)&channelName=PG5%20-%20AG-3%20%E2%80%94%20Cyber%20resilience%20for%20an%20agribusiness&createdTime=1791342186190&ngc=true) |

---

## Implemented Technologies

| Technology | Purpose |
|---|---|
| **pfSense** | Firewall configuration, inter-VLAN routing and network segmentation |
| **Nextcloud** | Business file storage, role-based access control and administrator MFA |
| **Wazuh** | Centralised security monitoring, authentication alerts and file integrity monitoring |
| **Restic** | Encrypted backups and file restoration |
| **MinIO** | Separate object storage repository for backup snapshots |
| **Ubuntu Server** | Hosting the application and monitoring services |

### Prototype Network

| Network | VLAN | Address |
|---|---|---|
| Office | 10 | 10.20.10.0/24 |
| Application / APP01 | 20 | 10.20.20.0/24 |
| Monitoring / MON01 | 30 | 10.20.30.0/24 |
| Backup / BKP01 | 40 | 10.20.40.0/24 |
| Management (design) | 99 | 10.20.99.0/24 |

---

## Project Outcomes

The prototype demonstrated:

- Firewall segmentation and selected permitted and blocked communication paths.
- Nextcloud role-based file access and administrator TOTP authentication.
- Wazuh monitoring of selected authentication and file-integrity events.
- Monitoring of successful and failed backup operations.
- Encrypted Restic backup storage in MinIO.
- Detection of controlled ransomware-like file changes and restoration of affected synthetic files.

**Limitations:** Full Nextcloud disaster recovery, backup immutability, independent off-site recovery and production-level network isolation were not demonstrated.

---

**AG3 — Group PG5 | COIT20265 | CQUniversity Australia | 2026**

*Academic project developed for assessment purposes. The prototype uses controlled testing and does not represent a production deployment.*
