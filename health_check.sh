#!/bin/bash

THRESHOLD=80
LOGFILE="$HOME/log/system_health_$(date +'%Y-%m-%d_%H-%M-%S').log"

echo "==============================" | tee -a "$LOGFILE"
echo "System Health Report" | tee -a "$LOGFILE"
echo "Generated on: $(date)" | tee -a "$LOGFILE"
echo "==============================" | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
# To check disk utilization above 80%
echo "Filesystem Report (Usage > ${THRESHOLD}%):" | tee -a "$LOGFILE"
DISK_ALERT=$(df -hP | grep -e "8.%" -e "9.%" -e "100%")
if [ -z "$DISK_ALERT" ]; then
    echo "All filesystems are under control." | tee -a "$LOGFILE"
else
    echo "$DISK_ALERT" | tee -a "$LOGFILE"
fi
echo | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
# To check Memory utilization
echo "Memory Usage Report:" | tee -a "$LOGFILE"
free -h | tee -a "$LOGFILE"
MEM_TOTAL=$(free | awk '/Mem:/ {print $2}')
MEM_USED=$(free | awk '/Mem:/ {print $3}')
MEM_USAGE=$((MEM_USED * 100 / MEM_TOTAL))
echo "Memory Usage: ${MEM_USAGE}%" | tee -a "$LOGFILE"
if [ "$MEM_USAGE" -gt "$THRESHOLD" ]; then
    echo "ALERT: Memory usage is above ${THRESHOLD}%!" | tee -a -a "$LOGFILE"
fi
echo | tee -a "$LOGFILE"
echo "Top 5 Memory-Consuming Processes:" | tee -a "$LOGFILE"
ps -eo pid,comm,%mem --sort=-%mem | head -6 | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
# To check CPU utilization
echo "CPU Usage Report:" | tee -a "$LOGFILE"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: ${CPU_USAGE}%" | tee -a "$LOGFILE"
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "ALERT: CPU usage is above ${THRESHOLD}%!" | tee -a -a "$LOGFILE"
fi
echo "Top 5 CPU-Consuming Processes:" | tee -a "$LOGFILE"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6 | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
echo | tee -a "$LOGFILE"
# To check SELinux status
echo "SELinux Status Report:" | tee -a "$LOGFILE"
sestatus | grep -e "policy name" -e "mode" -e "SELinux status" | tee -a "$LOGFILE"


