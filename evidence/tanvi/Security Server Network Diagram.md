# Network Diagram alignment with Security Server
![1](./images/d1.png)  

MON01 is the project’s central security-monitoring system. It is located in the dedicated Security VLAN 30 with the address 10.20.30.10, separating monitoring services from users, application services, backups and management devices.  
MON01 aligns with the other project components in the following ways:  
- APP01 monitoring: A Wazuh agent installed on APP01 sends authentication logs, file-integrity events, vulnerability information, CIS configuration results and backup logs to MON01.  
- Failed-login detection: MON01 identifies unsuccessful authentication attempts against APP01, helping detect password guessing and possible unauthorised access.  
- File Integrity Monitoring: It monitors changes to important Nextcloud files and directories. During the controlled ransomware simulation, MON01 recorded 61 file-integrity events and generated three custom ransomware-style alerts.  
- Backup monitoring: APP01 sends its backup results to MON01. The Wazuh dashboard recorded five successful and nine failed backup events, allowing the team to identify whether the scheduled Restic backup process completed successfully.  
- BKP01 isolation: MON01 does not directly monitor BKP01. Instead, APP01 communicates with MinIO on BKP01 and reports backup outcomes to MON01. This limits unnecessary access to the backup server and helps preserve its isolation.  
- pfSense integration: pfSense controls communication between MON01 and the other VLANs. Only necessary monitoring traffic is permitted, while unrelated connections are blocked to reduce lateral movement.  
- Incident detection and recovery support: MON01 detects and records suspicious activity but does not perform the backup or restoration itself. Restic and MinIO provide recovery, while MON01 supplies the alerts and evidence needed to begin investigation and recovery.  
  
Therefore, MON01 connects the project’s prevention, detection and recovery functions. pfSense and access controls provide prevention, MON01 provides centralised detection and visibility, and APP01–BKP01 backup integration provides recovery. This makes MON01 essential for demonstrating that the project can identify security incidents, monitor backup reliability and support an evidence-based response.  
