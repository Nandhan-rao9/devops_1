# Nginx Log Analyser

This project is a simple command-line tool to analyze Nginx access logs. It's designed to practice basic shell scripting skills.

## Project Goal

The goal of this project is to create a shell script that reads an Nginx log file and provides specific information about the requests.

## Requirements

Create a shell script that reads the log file and provides the following information from the logfile:

- Top 5 IP addresses with the most requests
- Top 5 most requested paths
- Top 5 response status codes
- Top 5 user agents


## Output 

The script will produce output similar to this:

##################################################################
############## NGNIX LOG ANALYSER ################################
##################################################################
word count in log : 
7605 ngnix-access.log

top 5 IP addresses with the most requests :
178.128.94.113 - 1087requests
142.93.136.176 - 1087requests
138.68.248.85 - 1087requests
159.89.185.30 - 1086requests
86.134.118.70 - 277requests

top 5 most requested paths :
/v1-health - 4560 requests
/ - 270 requests
/v1-me - 232 requests
/v1-list-workspaces - 127 requests
/v1-list-timezone-teams - 75 requests

top 5 status codes :
200 - 5740requests
404 - 937requests
304 - 621requests
400 - 192requests
"-" - 31requests

top 5 user agents :
DigitalOcean - 4347 requests
Mozilla/5.0 - 513 requests
Mozilla/5.0 - 332 requests
Custom-AsyncHttpClient - 294 requests
Mozilla/5.0 - 282 requests