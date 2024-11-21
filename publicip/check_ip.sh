#!/bin/bash

# Define the directory where the files will be stored
DIR=~/automation/publicip

# File to store the last known IP address
IP_FILE="$DIR/last_ip.txt"
# Log file to store the IP addresses and timestamps
LOG_FILE="$DIR/ip_log.txt"

# Fetch the current public IP address
CURRENT_IP=$(curl -s api.ipify.org)

# Check if the last IP file exists
if [ -f "$IP_FILE" ]; then
    LAST_IP=$(cat "$IP_FILE")
else
    LAST_IP=""
fi

# Log the current IP with timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP - Current IP: $CURRENT_IP" >> "$LOG_FILE"

# Compare current IP with last known IP
if [ "$CURRENT_IP" != "$LAST_IP" ]; then
    echo "IP has changed from $LAST_IP to $CURRENT_IP"
    # Update the last known IP address
    echo "$CURRENT_IP" > "$IP_FILE"
    # You can add notification logic here (e.g., send an email or alert)
else
    echo "IP has not changed."
fi