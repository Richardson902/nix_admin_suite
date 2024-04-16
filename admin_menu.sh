#!/bin/bash

#Define functions for submenus
usermanagement_submenu() {
	while true; do
		clear
		echo "User Management"
		echo "---------------"
		echo "[1] Add User"
		echo "[2] Remove User"
		echo "[3] Group Manager"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1)
				echo "Add User chosen."
				./user_management/add_user.sh
				;;
			2)
				echo "Remove User chosen"
				./user_management/remove_user.sh
				;;
			3)
				./user_management/manage_groups.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}

monitoring_submenu() {
	while true; do
		clear
		echo "Monitoring"
		echo "----------"
		echo "[1] CPU Monitoring"
		echo "[2] Memory Monitoring"
		echo "[3] Network Monitoring"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) echo "CPU Monitoring chosen"
				./monitoring/cpu_monitoring.sh
				;;
			2) echo "Memory Monitoring chosen"
				./monitoring/memory_monitoring.sh
				;;
			3)	echo "Network Monitoring chosen"
				./monitoring/network_monitoring.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}


security_submenu() {
	while true; do
		clear
		echo "Security"
		echo "--------"
		echo "[1] Firewall Configuration"
		echo "[2] Vulnerability Scan"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) echo "Firewall Configuration chosen"
				./security/firewall_configuration.sh
				;;
			2)
				echo "Vulnerability Scan chosen"
				./security/vulnerability_scan.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}

networking_submenu() {
	while true; do
		clear
		echo "Network Manager"
		echo "---------------"
		echo "[1] Network Configuration"
		echo "[2] Network Diagnostics"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) echo "Network Configuration chosen"
				./networking/network_configuration.sh
				;;
			2) echo "Network Diagnostics chosen"
				./networking/network_diagnostics.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}

cronjobs_submenu() {
	while true; do
		clear
		echo "Cron Jobs"
		echo "---------"
		echo "[1] Schedule Backup"
		echo "[2] Schedule Package Update"
		echo "[3] Remove Scheduled Tasks"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) 
				echo "Schedule Backup chosen"
				./cron_jobs/schedule_backup.sh
				;;
			2)
				echo "Schedule Package Update chosen"
				./cron_jobs/schedule_package_update.sh
				;;
			3)
				echo "Remove Scheduled Tasks chosen"
				./cron_jobs/remove_tasks.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}

packagemanagement_submenu() {
	while true; do
		clear
		echo "Package Manager"
		echo "---------------"
		echo "[1] Install Required Packages"
		echo "[2] Update Packages"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) echo "Install Required Packages chosen"
				./package_management/required_packages.sh
				;;
			2) echo "Update Packages chosen"
				./package_management/software_update.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}

backuprestore_submenu() {
	while true; do
		clear
		echo "Backup/Restore"
		echo "--------------"
		echo "[1] Create Backup"
		echo "[2] Restore from Backup"
		echo "[0] Back to Main Menu"
		read -p "Enter your choice: " choice
		case $choice in
			1) echo "Create Backup chosen"
				./backup_restore/backup.sh
				;;
			2) echo "Restore from Backup chosen"
				./backup_restore/restore.sh
				;;
			0) 
				break ;;
			*) 
				echo "Invalid option. Please try again."
				read -p "Press Enter to continue..."
				clear
				;;
		esac
	done
}


#Define main menu
while true; do
	clear
	echo "Main Menu"
	echo "---------"
	echo "[1] User/Group Management"
	echo "[2] Monitoring"
	echo "[3] Security"
	echo "[4] Networking"
	echo "[5] Cron Jobs"
	echo "[6] Package Management"
	echo "[7] Backup/Restore"
	echo "[0] Exit"
	read -p "Enter your choice: " choice
	
	case $choice in
		1) usermanagement_submenu ;;
		2) monitoring_submenu ;;
		3) security_submenu ;;
		4) networking_submenu ;;
		5) cronjobs_submenu ;;
		6) packagemanagement_submenu ;;
		7) backuprestore_submenu ;;
		0) echo "Exiting..."; exit ;;
		*) echo "Invalid option. Please try again."
			read -p "Press Enter to continue..."
			clear
			;;
	esac
done
