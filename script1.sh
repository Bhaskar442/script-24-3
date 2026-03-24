#!/bin/bash
LOGFILE="/var/log/server-health.log"

CPU_THRESHOLD=75
MEM_THRESHOLD=75
DISK_THRESHOLD=75

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

#CPU CHECK

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print (100 - $8)}')

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ];
then
	echo "warning: cpu_usage is more $CPU_USAGE" >> $LOGFILE
else
	echo "info: cpu_usage is normal $CPU_USAGE" >> $LOGFILE
fi

#mem_check

MEM_USAGE=$(free | awk '/Mem/ {printf("%.0f"),$3/$2 * 100}')

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ];
then
	echo "Warning: mem usage is high $MEM_USAGE" >> $LOGFILE
else
	echo "info: eme usage is normal $MEM_USAGE" >> $LOGFILE
fi

#DISK_check

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ];
then
	echo "Warning: disk usage is more $DISK_USAGE" >> $LOGFILE
else
	echo "info: disk usage is $DISK_USAGE" >> $LOGFILE
fi


