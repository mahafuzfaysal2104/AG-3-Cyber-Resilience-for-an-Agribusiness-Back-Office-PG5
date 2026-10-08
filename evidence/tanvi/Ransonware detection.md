# Ransomware detection on MON01
![1](./images/R1.png)  

## Ransomware Detection
MON01 uses Wazuh File Integrity Monitoring and custom rules to detect ransomware-like file activity on APP01. During the controlled simulation, a script locked demonstration files in the monitored Nextcloud directory. Wazuh detected the resulting bulk file changes and generated three custom ransomware alerts, while the dashboard recorded 61 file-integrity events. The affected test files were subsequently restored from the MinIO backups. This demonstrated early detection and file-level recovery, although Wazuh detected the suspicious file changes rather than confirming the presence of real ransomware.  
