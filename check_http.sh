#!/bin/bash
######TEST2#####|
# 6/11/20 on Nagios server 10.128.0.3...35.224.66.98 
# https://raw.githubusercontent.com/Eli-Brown/NTI-320-Atom-Smasher/master/nrpe-http-eli/check_http
# https://github.com/Eli-Brown/NTI-320-Atom-Smasher/blob/master/nrpe-http-eli/check_http
# nrpe-http-eli/check_http

######TEST1#####
curl -v http://35.224.66.98/nagios

curl -s -o http_HTTP_Status_Response.txt -w "%{http_code}" http://35.224.66.98/nagios #####nagios or example?
http_code "0" ="inactive"
http_code "200" ="No HTTP Service error"
http_code "100" ="HTTP Service error"
http_HTTP-Status-Response = $(curl -s -o http_HTTP_Status_Response.txt -w) "%{http_code}" http://127.0.0.1/nagios/
if [  $ http_HTTP_Status_Response != "200" ]; then
	echo "No HTTP Service error"
		exit 200;
	
	elif [  $ http_HTTP_Status_Response != "100" ]; then
		echo "HTTP Service error"
		exit 100;
	
	elif [  $ http_HTTP_Status_Response != "0" ]; then
		echo "**Inactive HTTP Service**"
		exit 0;
   	
else
    echo "Server returned:"    
    echo  "%{http_code}"
    exit;
fi
