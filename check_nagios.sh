#!/bin/bash
# from the nagios server
# is nagios running

status=$(systemctl status nagios | grep -i running | awk '{print $3}')
status2=$(systemctl status nagios | grep -i dead | awk '{print $3}')
status3=$(systemctl status nagios | grep -v UTC | grep failed | awk '{print $9}')



if [ "$status" == "(running)" ]; then
    echo "STATUS:OK"
    exit 0;
    
  elif [ "$status2" == "(dead)" ]; then
    echo "STATUS:CRITICAL"
    exit 2;
    
  elif [ "$status3" == "failed" ] ; then
    echo "STATUS:WARNING"
    exit 1;
    
else
   echo "STATUS:UNKNOWN"
   exit 3;
fi
