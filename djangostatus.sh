#!/bin/bash
state=$(curl -Is {http://127.0.0.1:8000} | head -n 1 | awk '{print $3}')
OK=OK
Bad=Bad

echo $state

if [ $state == OK ]; then
   echo "STATUS:OK"
 
 elif [ $state == Bad ]; then
   echo "STATUS:WARNING"
   exit 1;

 else
   echo "STATUS:UNKNOWN"
   exit 3;

fi
