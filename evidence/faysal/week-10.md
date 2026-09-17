# Week 10

## Created a final bucket to back up real data
Navigate to the Project Folder: `cd ~/AG-3-Cyber-Resilience-for-an-Agribusiness-Back-Office-PG5`  
Create a new and Final Bucket: `mc mb localminio/ag3-plains-pastoral-backups`  
Check List of Buckets: `mc ls localminio`    

<img width="1373" height="293" alt="image" src="https://github.com/user-attachments/assets/248a2a36-0678-488c-af22-3caef9e4a8ad" />  
<img width="1570" height="844" alt="image" src="https://github.com/user-attachments/assets/83263f99-18ab-4d88-8062-acbe3209377c" />  

<img width="2041" height="717" alt="image" src="https://github.com/user-attachments/assets/5ce5449d-42e6-4944-9e79-33c1e10a602b" />  


## Confirm the admin alias works and the production bucket exists
`mc ls localminio`
Check System is running: `systemctl is-active minio`
<img width="890" height="98" alt="image" src="https://github.com/user-attachments/assets/1f806ea8-ca2d-47f1-bf67-2b7198ed7b65" />



## Create the restricted policy file
<img width="1915" height="1079" alt="image" src="https://github.com/user-attachments/assets/bda7ff30-477b-4501-88cf-eb42ac760b5b" />

## Create the policy inside MinIO
`mc admin policy create localminio ag3-restic-backup ~/ag3-restic-policy.json`

Why we use it:  
mc admin policy create = creates a MinIO access policy.  
localminio = your working MinIO admin alias.  
ag3-restic-backup = the name we are giving this restricted policy.  
~/ag3-restic-policy.json = the permissions file you just created.  
<img width="1918" height="89" alt="image" src="https://github.com/user-attachments/assets/9967125f-fbf8-4773-a2da-521d4cce70b8" />




## Create the restricted MinIO user  

 
## Attach the restricted policy to the user  

## 
