#!/bin/bash

# Initialize a variable to store the notification ID
notification_id=0

while true; do
  # Check battery level
  battery_level=$(cat /sys/class/power_supply/BAT*/capacity)

  # Check if battery is discharging
  battery_status=$(cat /sys/class/power_supply/BAT*/status)
  
  if [ "$battery_status" = "Discharging" ]; then
    # Set the threshold for notifications (in this case, 20%)
    if [ $battery_level -le 20 ]; then
      # Send a notification using notify-send and store the notification ID
      notification_id=$(notify-send -u critical -r $notification_id -t 3000 "Low Battery" "Battery level is $battery_level%")
    fi
    
    if [ $battery_level -le 10 ]; then
      systemctl suspend
    fi
    # If the battery is not discharging, clear the notification (optional)
    #notify-send -r $notification_id -t 5000 "Battery Status" "Battery level is $battery_level%"
  fi
  # Sleep for 3 minute before checking again
  sleep 180 
done
