#!/bin/bash

state=$(systemctl status slapd | grep Active | awk '{print $2}')
inactive="inactive"
active="active"
failed="failed"

if [ $state == $active ]; then
      echo "STATUS:OK"
      exit 0;

   elif [ $state == $inactive ]; then
      echo "STATUS:WARNING"
      exit 1;
      
    elif [ $state == $failed ]; then
      echo "STATUS:CRITICAL"
      exit 2;

else
   echo "STATUS:UNKNOWN"
   exit 3;

fi
