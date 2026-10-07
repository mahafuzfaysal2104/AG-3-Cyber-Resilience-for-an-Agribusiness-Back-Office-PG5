
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
| **AG3 Detailed Network Design** | Network alternatives, selected architecture, VLANs, IP addressing and hardware recommendations | [View Document](PASTE_LINK_HERE) |
| **AG3 Firewall, Segmentation and Access Control Design** | pfSense firewall policies, VLAN communication rules, Nextcloud access controls and firewall testing | [View Document](PASTE_LINK_HERE) |
| **AG3 Prototype Implementation Plan and Guide** | Implementation steps, system configuration, integration and troubleshooting | [View Document](PASTE_LINK_HERE) |
| **AG3 Security Monitoring and Wazuh Implementation** | Wazuh simulation, MON01 deployment, APP01 agent integration and monitoring results | [View Document](PASTE_LINK_HERE) |
| **AG3 Prototype Testing and Validation Report** | Prototype screenshots, firewall validation, security monitoring, backup testing and controlled recovery evidence | [View Document](PASTE_LINK_HERE) |
| **AG3 Risk Assessment Report** | Security risks, vulnerabilities, existing controls, residual risks and recommended treatments | [View Document](PASTE_LINK_HERE) |
| **AG3 Risk Assessment Register** | Risk ratings, likelihood, impact, responsible owners and mitigation actions | [View Document](PASTE_LINK_HERE) |
| **AG3 Cyber Resilience Incident Recovery Plan** | Incident response procedures, containment, evidence preservation and service recovery planning | [View Document](PASTE_LINK_HERE) |

---

## Prototype Demonstration Videos

The following videos provide visual evidence of the implemented prototype and selected security tests.

| Video | Demonstration | Link |
|---|---|---|
| **V01** | Overall prototype and physical network setup | [Watch Video](PASTE_VIDEO_LINK_HERE) |
| **V02** | Secure Nextcloud file access and multi-factor authentication | [Watch Video](PASTE_VIDEO_LINK_HERE) |
| **V03** | Wazuh File Integrity Monitoring (FIM) | [Watch Video](PASTE_VIDEO_LINK_HERE) |
| **V04** | Wazuh monitoring of successful and failed backup operations | [Watch Video](PASTE_VIDEO_LINK_HERE) |
| **V05** | Restic encrypted backup and MinIO repository demonstration | [Watch Video](PASTE_VIDEO_LINK_HERE) |
| **V06** | Controlled ransomware-like file impact, detection and recovery | [Watch Video](PASTE_VIDEO_LINK_HERE) |

### Final Prototype Demonstration

**[Watch the Complete AG3 Prototype Demonstration](PASTE_FINAL_DEMO_LINK_HERE)**

The consolidated demonstration video should be less than 10 minutes, as required by the assessment specification.

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
