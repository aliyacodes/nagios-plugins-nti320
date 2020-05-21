#!/bin/bash
apt-get install nfs-client

showmount -e 10.128.0.57 #nfs server I spun up
mkdir /mnt/test
echo "10.128.0.47:/var/nfsshare/testing    /mnt/test     nfs   defaults 0 0" >> /etc/fstab
mount -a

status="0"                                  # Change the status to test different alert states

if [ $status == "0" ]; then
    echo "STATUS:OK"
    exit 0;
    
  elif [ $status == "2" ]; then
    echo "STATUS:CRITICAL"
    exit 2;
    
  elif [ $status == "1" ] ; then
    echo "STATUS:WARNING"
    exit 1;
    
else
   echo "STATUS:UNKNOWN"
   exit 3;
fi
