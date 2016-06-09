#!/bin/bash

i="0"
url="127.0.0.1"

while [ $i -lt 10 ]
do
curl $url  &
i=$[$i+1]
done
