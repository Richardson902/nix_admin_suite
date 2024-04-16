#!/bin/bash

#Network Diagnostics Script

echo "Running Network Diagnostics..."
echo "-------------------------------"
sleep 1

echo "1. Checking IP Configuration..."
ifconfig
sleep 1

echo "2. Checking Network Connectivity..."
ping -c 4 google.com
echo ""
sleep 1

echo "3. Checking Routing Table..."
route -n
echo ""
sleep 1

echo "4. Checking DNS Resolution..."
nslookup google.com
sleep 1

read -p "Network Diagnostics Completed. Press Enter to continue..."

