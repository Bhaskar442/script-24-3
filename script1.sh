#!/bin/bash
LOGFILE="/var/log/server-health.log"

CPU_THRESHOLD=75
MEM_THRESHOLD=75
DISK_THRESHOLD=75

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

#CPU CHECK

CPU_USAGE=$(top -bn1 | grep "cpu(s)" | awk '{print 100 - $8}')

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ];
then
	echo "warning: cpu_usage is more $CPU_USAGE" >> $LOGFILE
else
	echo "info: cpu_usage is normal $CPU_USAGE" >> $LOGFILE
fi


