#!/bin/bash

LOGFILE="/var/log/nginx/access.log"

echo "Number of 404 errors:"
grep "404" "$LOGFILE" | wc -l
echo

echo "Top 5 IPs by request count:"
awk '{print $1}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5
echo

echo "Most requested pages:"
awk '{print $7}' "$LOGFILE" | sort | uniq -c | sort -nr | head -5

