![3](./images/E3.png)  
## Endpoint route and interface configuration  & Ping test   
![4&5](./images/E4.png)  
## ss listener output on MON01  
![6](./images/E6.png)  
## Netcat port tests from endpoint  
![7](./images/E7.png)  
## Agent service and dashboard status  
![8](./images/E8.png)  
## Endpoint security overview  
![9](./images/E9.png)  
  
**Wazuh Agent Deployment on the Second Kali VM**
During the simulation, I created a second Kali Linux virtual machine to act as a monitored endpoint. I added the official Wazuh repository, installed the Wazuh agent package and configured the agent with the IP address of the first Kali VM running the Wazuh manager. I then enrolled the endpoint with the manager, enabled the agent service and started it. After confirming network connectivity over the required Wazuh ports, I verified that the new agent appeared as active on the Wazuh dashboard.  
The purpose of deploying this agent was to test communication between an endpoint and the central Wazuh monitoring server before working with the real APP01 system. The agent collected security information from the second Kali VM and forwarded it to MON01 for analysis. This allowed me to simulate and detect failed login attempts, file integrity changes, software vulnerabilities and CIS configuration weaknesses. The successful deployment confirmed that Wazuh could centrally monitor a remote endpoint and prepared me for deploying the agent on Shourabh’s APP01 server.  
