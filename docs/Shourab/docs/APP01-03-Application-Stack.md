# APP01-03 – Application Stack Installation

## Project

**AG-3 – Cyber Resilience for an Agribusiness Back Office**

**Component:** APP01 – Identity and Application Server

---

# Objective

Prepare the APP01 Ubuntu Server for hosting the Nextcloud application by installing the required web server, database server, and PHP runtime environment.

---

# Background

Nextcloud is a PHP-based web application that requires three core components:

- Apache Web Server to host the application.
- MariaDB Server to store application data.
- PHP and its required extensions to execute the application.

Installing these components establishes the application platform for subsequent Nextcloud deployment.

---

# Environment

| Item | Value |
|------|------|
| Server | APP01 |
| Operating System | Ubuntu Server 24.04.4 LTS |
| Hostname | app01 |
| Administrator | shourab |
| Virtualisation | VMware Fusion |
| Network | Static IP (172.16.229.150) |

---

# Implementation

## 1. Update Ubuntu Packages

Before installing additional software, the package repository was refreshed to ensure the latest package information was available.

Command executed:

```bash
sudo apt update
```

Result:

- Package repository updated successfully.
- System confirmed latest package information.

---

## 2. Install Apache Web Server

Apache was installed as the primary web server responsible for hosting the Nextcloud web application.

Command executed:

```bash
sudo apt install apache2 -y
```

Verification:

```bash
sudo systemctl status apache2
```

Result:

- Apache installed successfully.
- Apache service running.

---

## 3. Install MariaDB Server

MariaDB was installed to provide the relational database required by Nextcloud.

Command executed:

```bash
sudo apt install mariadb-server -y
```

Verification:

```bash
sudo systemctl status mariadb
```

Result:

- MariaDB installed successfully.
- MariaDB service running.

---

## 4. Install PHP

PHP and the required modules for Nextcloud were installed.

Command executed:

```bash
sudo apt install php libapache2-mod-php php-cli php-common php-mysql php-gd php-curl php-mbstring php-intl php-imagick php-xml php-zip php-bz2 php-gmp unzip -y
```

Verification:

```bash
php -v
```

Result:

- PHP installed successfully.
- PHP CLI functioning correctly.

---

# Verification Summary

| Component | Status |
|-----------|--------|
| Ubuntu Package Repository | Updated |
| Apache Web Server | Running |
| MariaDB Database Server | Running |
| PHP Runtime | Installed |

---

# Security Considerations

The application stack was installed before deploying Nextcloud to establish a controlled server environment.

Using separate components provides flexibility for future maintenance and supports secure application deployment.

Database access will be configured using a dedicated database account rather than the MariaDB root account, following the principle of least privilege.

---

# Outcome

The APP01 server has been successfully prepared to host the Nextcloud application.

Apache, MariaDB and PHP are installed and operational.

The server is now ready for database configuration and Nextcloud deployment.

---

# Evidence

The following screenshots were collected during implementation.

```
evidence/APP01/
```

Recommended filenames:

```
03-package-update.png
04-apache-running.png
05-mariadb-running.png
06-php-version.png
```

---

# Next Task

APP01-04 – MariaDB Configuration

Tasks include:

- Secure MariaDB installation.
- Create the Nextcloud database.
- Create a dedicated database user.
- Assign database privileges.
- Verify database connectivity.

---

# Integration Notes

This application stack forms the foundation of the APP01 server.

During the integration phase:

- **Akib's pfSense** will provide controlled network access to APP01.
- **Tanvi's Wazuh** will monitor the server and collect security events.
- **Faysal's MinIO** will provide backup and recovery services for the application data.

The application stack has been prepared to support these integrations in later project stages.

---

# Author

Ashraful Abedin Shourab

COIT20265 Networks and Information Security Project

Group PG5

2026
