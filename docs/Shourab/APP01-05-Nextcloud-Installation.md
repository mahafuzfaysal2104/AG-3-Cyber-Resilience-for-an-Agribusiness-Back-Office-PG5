# APP01-05 – Nextcloud Installation

## Project

**AG-3 – Cyber Resilience for an Agribusiness Back Office**

**Component:** APP01 – Identity and Application Server

---

# Objective

Install and configure the Nextcloud application on the APP01 Ubuntu Server to provide a secure self-hosted collaboration and file-sharing platform for the agribusiness environment.

---

# Background

Nextcloud is an open-source, self-hosted collaboration platform that provides secure file storage, file sharing, user management, and application extensibility. It was selected for this project because it supports secure authentication, role-based access control, multi-factor authentication, auditing, and integration with monitoring and backup solutions.

The application was deployed using Apache, PHP and MariaDB on Ubuntu Server.

---

# Environment

| Item | Value |
|------|------|
| Server | APP01 |
| Operating System | Ubuntu Server 24.04.4 LTS |
| Web Server | Apache2 |
| Database | MariaDB |
| PHP Version | PHP 8.3 |
| Nextcloud Version | Nextcloud Hub 10 (34.0.2) |
| Hostname | app01 |

---

# Design Decisions

Several design decisions were made before deployment.

- Ubuntu Server was selected instead of Ubuntu Desktop to minimise resource usage and reduce the attack surface.
- Apache was selected as the web server to provide a stable and widely supported hosting platform for Nextcloud.
- MariaDB was configured with a dedicated database and application account following the Principle of Least Privilege.
- The Nextcloud data directory was placed outside the web root (`/var/ncdata`) to improve security and prevent direct web access to uploaded files.

---

# Implementation

## Download Nextcloud

The latest stable Nextcloud release was downloaded from the official Nextcloud repository.

```bash
wget https://download.nextcloud.com/server/releases/latest.zip
```

---

## Extract the Installation Package

The downloaded archive was extracted.

```bash
unzip latest.zip
```

---

## Deploy Nextcloud

The extracted directory was moved into Apache's web directory.

```bash
sudo mv nextcloud /var/www/
```

---

## Configure Ownership

Ownership of the application directory was assigned to Apache.

```bash
sudo chown -R www-data:www-data /var/www/nextcloud
```

---

## Configure Permissions

Directory permissions were configured.

```bash
sudo chmod -R 755 /var/www/nextcloud
```

---

## Enable Required Apache Modules

The required Apache modules were enabled.

```bash
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
```

Apache was restarted after enabling the modules.

```bash
sudo systemctl restart apache2
```

---

## Configure Apache Virtual Host

A dedicated Apache Virtual Host was created for Nextcloud.

The default Apache site was disabled.

```bash
sudo a2dissite 000-default.conf
```

The Nextcloud site was enabled.

```bash
sudo a2ensite nextcloud.conf
```

Apache configuration was verified.

```bash
sudo apache2ctl configtest
```

Apache was restarted.

```bash
sudo systemctl restart apache2
```

---

## Configure Secure Data Directory

A dedicated data directory outside the web root was created.

```bash
sudo mkdir -p /var/ncdata
sudo chown -R www-data:www-data /var/ncdata
sudo chmod 750 /var/ncdata
```

---

## Complete Nextcloud Installation

The web-based installer was completed.

Configuration included:

- Administrator account creation.
- Database connection using the dedicated MariaDB account.
- Database name: `nextcloud`
- Database host: `localhost`
- Data directory: `/var/ncdata`

---



# Security Considerations

Several security measures were incorporated during installation.

- Application files are owned by the Apache service account.
- A dedicated application database account is used instead of the MariaDB root account.
- Database communication is restricted to localhost.
- User data is stored outside the web root.
- Only the required Apache modules were enabled.
- Optional Nextcloud applications were not installed to minimise the attack surface.

These measures support the cyber resilience objectives of the project.

---

# Outcome

Nextcloud was successfully deployed on APP01.

The application is operational and accessible through the Apache web server.

The deployment provides the foundation for implementing identity management, HTTPS, multi-factor authentication, monitoring and backup integration during subsequent project stages.

---

# Next Task

APP01-06 – Nextcloud Post-Installation Configuration

Tasks include:

- Configure trusted domains.
- Configure background jobs.
- Configure logging.
- Configure regional settings.
- Tune PHP OPcache.
- Configure application settings.

---

# Integration Notes

The deployed Nextcloud application has been prepared for future integration with the remaining project components.

- **Akib's pfSense** will provide controlled network access.
- **Tanvi's Wazuh** will provide monitoring and security event collection.
- **Faysal's MinIO** will provide backup and recovery capabilities.

The application deployment establishes the core service required for these future integrations.

---

# Author

Ashraful Abedin Shourab

COIT20265 Networks and Information Security Project

Group PG5

2026
