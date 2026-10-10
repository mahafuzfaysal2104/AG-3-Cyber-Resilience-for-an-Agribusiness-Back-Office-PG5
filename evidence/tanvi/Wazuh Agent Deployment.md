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
Wazuh Agent on the Second Kali VM In order to prepare a test, I created the second Kali Linux VM as the endpoint to be monitored. First, I added the Wazuh official repository and installed the Wazuh agent software on the second VM by providing its IP address of the first Kali Linux with the Wazuh manager installed on it. Then, I enrolled the endpoint and enabled the Wazuh agent service and started it. After checking the ability of the network communication over the required Wazuh ports, I found the newly created Wazuh agent on the dashboard.  
This installation of the Wazuh agent was conducted in order to test communications between the endpoint and the central Wazuh monitoring service before the deployment of the Wazuh agent on the actual APP01 machine. The information about the security state of the second Kali Linux VM had been sent from the second VM and analyzed on MON01. That helped to detect failed login attempts, file modifications, vulnerabilities in the installed software and configuration issues according to the CIS standard.  
