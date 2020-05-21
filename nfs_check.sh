#!/bin/bash

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4

status=`${SHOWMOUNT} -e ${nfs_server} 2>&1`

if [ $? -ne 0 ]
then
exitstatus=${STATE_CRITICAL}
else
exitstatus=${STATE_OK}
fi

exit $exitstatus
