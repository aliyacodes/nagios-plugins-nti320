#!/bin/bash
# from the client

status=$(cat /etc/fstab | awk '{print $1}')
inactive="inactive"
active="active"
failed="failed"

if [ $status == $active ]; then
    echo "STATUS:OK"
    exit 0;
  elif [ $status == $inactive ]; then
    echo "STATUS:CRITICAL"
    exit 2;
  elif [ $status == $failed ] ; then
    echo "STATUS:WARNING"
    exit 1;
else
   echo "STATUS:UNKNOWN"
   exit 3;
fi
