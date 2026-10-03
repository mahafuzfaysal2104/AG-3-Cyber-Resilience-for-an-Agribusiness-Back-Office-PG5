# CIS Hardening
![1](./images/W8-E1.png)  
![2](./images/W8-E2.png)  
![3](./images/W8-E3.png)  
![4](./images/W8-E4.png)  
![5](./images/W8-E5.png)  
![6](./images/W8-E6.png)  
![7](./images/W8-E7.png)  


## Explanation:  
The screenshots demonstrate incremental CIS security hardening of the Kali Linux endpoint monitored through Wazuh. The initial Security Configuration Assessment recorded 82 passed controls, 99 failed controls and a compliance score of 45%.  
The remediation focused on reducing the attack surface by disabling unnecessary filesystem modules. A configuration file named cis-unused-filesystems.conf was created under /etc/modprobe.d/. Rules were added to prevent the loading of unused filesystems, including cramfs, freevxfs, jffs2, hfs, hfsplus, squashfs and udf. These modules were configured with restrictive install directives and blacklist entries.  
After applying the changes, the Wazuh agent was restarted using systemctl restart wazuh-agent, allowing MON01 to reassess the endpoint. Successive scans showed measurable improvement: passed checks increased from 82 to 89, failed checks decreased from 99 to 92, and the overall CIS compliance score increased from 45% to 49%.  
This evidence confirms that Wazuh successfully identified configuration weaknesses, supported targeted remediation and verified the resulting improvement. Although the endpoint still had 92 failed checks, the implementation demonstrates a repeatable process for progressively improving system security against the CIS benchmark.  
