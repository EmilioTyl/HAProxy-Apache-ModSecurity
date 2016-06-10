#!/bin/bash

i="0"
url="192.168.33.18" #Victim

while [ $i -lt 10 ]
do
curl $url  &
i=$[$i+1]
done

