#!/bin/bash
# server-stats.sh - Basic server performance stats

echo "======================================"
echo "        SERVER PERFORMANCE STATS       "
echo "======================================"

# Stretch goal: OS version
echo -e "\n OS Version:"
cat /etc/os-release | grep -E 'PRETTY_NAME' | cut -d= -f2 | tr -d '"'

# Stretch goal: Uptime
echo -e "\n Uptime:"
uptime -p

# Stretch goal: Load Average
echo -e "\n Load Average:"
uptime | awk -F'load average:' '{ print $2 }'

# Stretch goal: Logged in users
echo -e "\n Logged in users:"
who

# Stretch goal: Failed login attempts (last 10)
echo -e "\n Failed login attempts (last 10):"
lastb | head -n 10

# CPU Usage
echo -e "\n Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | \
awk '{print "User: " $2 "%, System: " $4 "%, Idle: " $8 "%, Total Used: " 100-$8 "%"}'

# Memory Usage
echo -e "\n Memory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB, Free: %s MB, Usage: %.2f%%\n", $3,$4,$3*100/$2 }'

# Disk Usage
echo -e "\n Disk Usage:"
df -h --total | grep total | \
awk '{print "Used: " $3 ", Free: " $4 ", Usage: " $5}'

# Top 5 processes by CPU usage
echo -e "\n Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 processes by Memory usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo -e "\n======================================"
echo "        END OF REPORT                  "
echo "======================================"
