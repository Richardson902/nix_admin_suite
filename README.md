# Admin Suite

Admin Suite is a collection of scripts for Linux system administration tasks, organized into subfolders corresponding to different areas of system management. It features a main menu script (`admin_menu.sh`) that provides easy access to various functions.

## Main Menu Options

- **User/Group Management**
  - Add, remove, or manage users and groups.
- **Monitoring**
  - Monitor CPU, memory, and network usage.
- **Security**
  - Configure firewall, perform vulnerability scans.
- **Networking**
  - Configure network settings, diagnose network issues.
- **Cron Jobs**
  - Schedule tasks like backups and package updates.
- **Package Management**
  - Install required packages, update software.
- **Backup/Restore**
  - Create backups and restore from backups.

## Instillation

To install and setup the admin_suite package, simply clone or download the repository to your local machine.

## Usage

1. Once installed, Navigate to the admin_suite directory.
2. Make the scripts executable:

```bash
chmod -R +x ../admin_suite
```

3. Run the main menu script as sudo:

```bash
sudo ./admin_menu.sh
```

## Script Customization

There are a few scripts in the suite that you can edit for your specific use case. For example, the **backup.sh** script is demonstrated by
backing up the /tmp folder, and the **restore.sh** script restores the backup to the /tmp folder. Scripts like these are meant to be editable
for the user, so they can take advantage of the already implemented logic, and change the outcome. Feel free to set custom paths yourself.
