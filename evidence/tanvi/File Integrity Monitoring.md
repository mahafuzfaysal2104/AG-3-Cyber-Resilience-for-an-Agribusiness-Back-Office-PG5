# File Integrity Monitoring  
![1](./images/W6-E3.png)  
![2](./images/W6-E4.png)  
![3](./images/W6-E5.png)  
![4](./images/W6-E6.png)  

## Explanation:  
File Integrity Monitoring detects changes to selected files and directories. It is useful because attackers, malware or accidental administrator actions may create unauthorised files, modify trusted configuration or scripts, or delete information. FIM provides evidence of what object changed, when it changed and what type of action occurred.  
Wazuh's FIM capability is provided by the syscheck component. Depending on its configuration, it can monitor changes periodically or in near real time and can compare file metadata and cryptographic checksums.  
I used the following dedicated test path so the activity would not damage an important system file:  
/home/vagrant/fim-test/test-file.txt  
I performed three controlled actions in sequence:
1.	created the test file.  
2.	changed its contents; and  
3.	deleted the file.  
This sequence allowed me to test the complete change lifecycle. Using a separate test directory was safer than changing a production configuration only to generate an alert.   

The creation event showed that Wazuh recognised a new object. The modification event showed that the integrity value no longer matched the earlier baseline. The deletion event showed that an object known to the baseline was no longer present. Together, these results verified more than a simple file-existence check.  
FIM is particularly valuable for protecting:  
•	Nextcloud and web-server configuration;  
•	backup scripts and scheduling files;  
•	Wazuh and pfSense-related configuration exports;  
•	certificate and key locations;  
•	privileged-account configuration; and  
•	directories containing important business files.  
The test demonstrates detection, not automatic recovery. If an important file is changed, the administrator still needs to decide whether the change was authorised, isolate the affected host when necessary, recover a trusted copy and investigate the responsible account or process.  
