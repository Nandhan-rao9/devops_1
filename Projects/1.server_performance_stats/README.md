
First script towards learning linux and shell scripting 

commands learnt :
free -h
::-shows the memory usage in human readable format

df -h 
::-shows "disk free" in human readable language

ps - process status

a - processes for all users
u - users description - (Adds columns: USER, %CPU, %MEM, etc.)
x - background processes

--sort=-%*** 
::-sorts the mentioned thing in *** ( eg: cpu,mem)

head -n 6 
::-shows only first 6 lines of o/p

ps aux/au --sort-%mem 
::- gest the processes running sorted by memory usage
