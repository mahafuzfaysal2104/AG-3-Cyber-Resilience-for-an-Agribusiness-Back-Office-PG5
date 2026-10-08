![1](./images/W9-E1.png)  

![2](./images/W9-E2.png)  

![3](./images/W9-E3.png)  

## Wazuh Agent Deployment on APP01
During the final implementation, I deployed the Wazuh agent on Sourabh’s Ubuntu-based APP01 server. I configured the agent with MON01’s IP address, 10.20.30.10, and enrolled it through the pfSense-controlled network. After confirming connectivity on Wazuh ports 1514 and 1515, I enabled and started the agent service. APP01 then appeared as an active endpoint on the MON01 dashboard. This connection allowed MON01 to monitor APP01 for failed logins, file-integrity changes, successful or failed backup events and ransomware-like activity.    
