#!/bin/bash

echo "=============================="
echo " SERVER PERFORMANCE OVERVIEW "
echo "=============================="
echo ""

echo "CPU USAGE:"
top -bn1 | grep "Cpu(s)"  
echo ""

echo "MEMORY USAGE:"
free -h
echo ""

echo "DISK USAGE:"
df -h
echo ""

echo "TOP 5 PROCESSES BY CPU USAGE:"
ps aux --sort=-%cpu | head -n 6
echo ""

echo "TOP 5 PROCESSES BY MEMORY USAGE:"
ps aux --sort=-%mem | head -n 6
echo ""
