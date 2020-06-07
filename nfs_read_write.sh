#!/bin/bash
# is it accepting read/write command

rwcheck="${showmount} -e ${10.128.0.28/mnt/test /mnt/test} 2>&1"

if [ "$rwcheck" == "rw" ]; 
     then
      echo "STATUS:OK"
      exit 0;
      
    elif [ "$rwcheck" == "x" ]; 
    then
      echo "STATUS:CRITICAL"
      exit 2;

else
   echo "STATUS:UNKNOWN"
   exit 3;

fi
