#!/bin/bash
# $1 is the first parameter received and states how many request show be made to 192.168.33.15,
# which is the IP of HaProxy

i=0
url="192.168.33.15" #Victim

while [ $i -lt $1 ]
do
curl -v $url
printf "\n"
let i=i+1 
done
