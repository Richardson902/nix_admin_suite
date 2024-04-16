#!/bin/bash

#Function to prompt for yes/no
prompt_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
            *) echo "Please answer: [y/n]" ;;
        esac
    done
}

#Clear existing rules
iptables -F
iptables -X

#Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#Allow loopback traffic
if prompt_yes_no "Allow loopback traffic?"; then
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
fi

#Allow established and related connections
if prompt_yes_no "Allow established and related connections?"; then
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
fi

#Detect SSH port
SSH_PORT=$(ss -tlpn 2>/dev/null | grep ssh | awk '{print $4}' | cut -d ':' -f 2)

#Allow SSH if port detected
if [ ! -z "$SSH_PORT" ]; then
    if prompt_yes_no "Allow SSH traffic on port $SSH_PORT?"; then
        iptables -A INPUT -p tcp --dport $SSH_PORT -j ACCEPT
    fi
else
    echo "SSH port not detected. Skipping SSH configuration..."
fi

#Allow HTTP and HTTPS
if prompt_yes_no "Allow HTTP traffic?"; then
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
fi

if prompt_yes_no "Allow HTTPS traffic?"; then
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT
fi

#Detect DNS port
if [ -f /etc/bind/named.conf.options ]; then
    DNS_PORT=$(grep -E -o '^\s*listen-on.*[0-9]+\s*{.*' /etc/bind/named.conf.options | grep -E -o '[0-9]+' | head -1)
else
    echo "BIND configuration file not found. Skipping DNS configuration..."
    DNS_PORT=""
fi

#Allow DNS if port detected
if [ ! -z "$DNS_PORT" ]; then
    if prompt_yes_no "Allow DNS traffic on port $DNS_PORT?"; then
        iptables -A INPUT -p udp --dport $DNS_PORT -j ACCEPT
        iptables -A INPUT -p tcp --dport $DNS_PORT -j ACCEPT
    fi
fi

#Detect NTP port
NTP_PORT=$(grep -E -o '^.*\b(ntp|ntp-server)\b.*' /etc/services | awk '{print $2}' | cut -d '/' -f 1)

#Allow NTP
if prompt_yes_no "Allow NTP traffic on port $NTP_PORT?"; then
    iptables -A INPUT -p udp --dport $NTP_PORT -j ACCEPT
fi

#Allow ICMP (Ping)
if prompt_yes_no "Allow ICMP (Ping)?"; then
    iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
fi

#Log dropped packets (optional)
if prompt_yes_no "Log dropped packets?"; then
    iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
fi

read -p "Firewall configured successfully. Press Enter to continue..."

