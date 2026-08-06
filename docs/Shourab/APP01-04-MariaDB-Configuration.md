# APP01-04 – MariaDB Security and Nextcloud Database Configuration

## Project

**AG-3 – Cyber Resilience for an Agribusiness Back Office**

**Component:** APP01 – Identity and Application Server

---

# Objective

Secure the MariaDB database server and prepare it for Nextcloud deployment by implementing security best practices, creating a dedicated application database, and configuring a least-privilege database user.

---

# Background

Nextcloud requires a relational database to store application data, including user accounts, file metadata, sharing permissions, application settings, and audit information. To support secure application deployment, MariaDB was configured following security best practices before installing Nextcloud.

---

# Environment

| Item | Value |
|------|------|
| Server | APP01 |
| Operating System | Ubuntu Server 24.04.4 LTS |
| Database Server | MariaDB |
| Hostname | app01 |
| Administrator | shourab |

---

# Part 1 – MariaDB Security Configuration

## Objective

Secure the default MariaDB installation by removing unnecessary accounts and restricting administrative access.

### Security Configuration

The MariaDB security script was executed.

```bash
sudo mysql_secure_installation
```

The following configuration was applied.

| Configuration | Selected Option | Reason |
|---------------|----------------|--------|
| Switch to `unix_socket` authentication | Yes | Allows secure local administration using Linux `sudo` authentication. |
| Change root password | No | Root authentication is managed through `sudo`; a separate database root password is unnecessary. |
| Remove anonymous users | Yes | Eliminates unnecessary accounts and reduces the attack surface. |
| Disallow remote root login | Yes | Prevents remote administrative access to the database server. |
| Remove test database | Yes | Removes unused resources from the production environment. |
| Reload privilege tables | Yes | Applies all security changes immediately. |

---

# Security Justification

The MariaDB root account is reserved exclusively for system administration.

Administrative access is performed using:

```bash
sudo mysql
```

rather than password-based authentication.

This approach reduces the risk of password compromise and follows Ubuntu's recommended security model.

---

# Part 2 – Nextcloud Database Configuration

## Objective

Prepare a dedicated database environment for the Nextcloud application.

---

## Create the Nextcloud Database

The following SQL command was executed.

```sql
CREATE DATABASE nextcloud
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
```

The `utf8mb4` character set was selected to provide full Unicode compatibility.

---

## Create a Dedicated Database User

A dedicated application account was created.

```sql
CREATE USER 'nextclouduser'@'localhost'
IDENTIFIED BY '********';
```

The account was restricted to `localhost`, allowing database access only from applications running on APP01.

---

## Grant Database Permissions

Permissions were granted only to the Nextcloud database.

```sql
GRANT ALL PRIVILEGES
ON nextcloud.*
TO 'nextclouduser'@'localhost';
```

This follows the Principle of Least Privilege by preventing the application from accessing any other databases.

---

## Apply Privilege Changes

```sql
FLUSH PRIVILEGES;
```

---

# Verification

The configuration was verified by logging in using the dedicated application account.

```bash
mysql -u nextclouduser -p
```

Verification steps included:

```sql
SHOW DATABASES;

USE nextcloud;
```

Results confirmed that:

- Authentication succeeded.
- The `nextcloud` database was accessible.
- The application user possessed the required permissions.
- The dedicated account functioned independently of the MariaDB root account.

---

# Security Considerations

Several security measures were implemented during database configuration.

- Root authentication uses `unix_socket`, eliminating the need for a separate root database password.
- Anonymous users were removed.
- Remote root database access was disabled.
- The default test database was removed.
- Nextcloud uses a dedicated database account instead of the root account.
- Database access is restricted to localhost.
- Database permissions are limited to the Nextcloud database only.

These measures reduce the attack surface and align with secure database administration practices.

---

# Outcome

MariaDB has been successfully secured and configured for Nextcloud deployment.

The server now contains:

- Secure MariaDB configuration
- Dedicated Nextcloud database
- Dedicated application database account
- Least-privilege permission model
- Verified database connectivity

APP01 is now ready for Nextcloud installation.

---

---

# Next Task

APP01-05 – Nextcloud Installation

Tasks include:

- Download Nextcloud
- Configure Apache Virtual Host
- Configure PHP settings
- Configure Apache modules
- Launch the web-based installation
- Connect Nextcloud to the MariaDB database

---

# Integration Notes

The database layer has been prepared to support the complete cyber resilience solution.

During the integration phase:

- Akib's pfSense firewall will control network access to APP01.
- Tanvi's Wazuh platform will monitor database and application events.
- Faysal's MinIO backup solution will protect the Nextcloud data and database.

The database configuration has been designed to support these future integrations.

---

# Author

Ashraful Abedin Shourab

COIT20265 Networks and Information Security Project

Group PG5

2026
