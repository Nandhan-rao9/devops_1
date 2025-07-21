#!/bin/bash 
#
#### author: Nandhan Rao
#
#
#
#
echo ''
echo '##################################################################'
echo '############## NGNIX LOG ANALYSER ################################'
echo '##################################################################'

echo 'word count in log : '
wc -l ngnix-access.log
echo ''

echo 'top 5 IP addresses with the most requests :'
awk '{print $1}' nginx-access.log | sort | uniq -c | sort -nr | awk '{print $2 " - " $1 "requests"}' | head -5
echo ''

echo 'top 5 most requested paths :'
awk '{print $7}' nginx-access.log | sort | uniq -c | sort -nr |awk '{print $2 " - " $1 " requests"}' | head -5
echo ''

echo 'top 5 status codes :'
awk '{print $9}' nginx-access.log | sort | uniq -c | sort -nr | awk '{print $2 " - " $1 "requests"}' | head -5
echo ''

echo 'top 5 user agents :'
awk -F\" '{print $6}' nginx-access.log | sort | uniq -c | sort -nr | awk '{print $2 " - " $1 " requests"}' | head -5
echo ''