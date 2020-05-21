
######TEST2#####|
#!/bin/bash
# on Nagios server 10.128.0.3
# https://raw.githubusercontent.com/Eli-Brown/NTI-320-Atom-Smasher/master/nrpe-http-eli/check_http
# https://github.com/Eli-Brown/NTI-320-Atom-Smasher/blob/master/nrpe-http-eli/check_http
# nrpe-http-eli/check_http

define command{
    command_name  check_http.sh
    command_line  /usr/lib64/nagios/plugins/check_http.sh  --url='$ARG1$' --extra_args='$ARG2$'
}

define service {
        host_name                       example
        service_description             service_name
        check_command                   check_http.sh!http://35.224.66.98/nagios/!--proxy http://user:name@host:8080 --user user:name --ntlm
        use                             generic-service
        notes                           some useful notes >>>not sure this is right
}


URL=$ARG1
KEY=$ARG2

curl -I -s -L <http://35.224.66.98/nagios/> | grep "HTTP/1.1"

######TEST1#####|#!/bin/bash
curl -v http://35.224.66.98/nagios/

curl -s -o HTTP-Status-Response.txt -w "%{http_code}" http://35.224.66.98/nagios/

http_HTTP-Status-Response=$(curl -s -o HTTP-Status-Response.txt -w "%{http_code}" http://35.224.66.98/nagios/
if [ $http_HTTP-Status-Response != "200" ]; then
	echo "No HTTP Service error"
    # handle error
else
    echo "Server returned:"
    cat HTTP-Status-Response.txt    
    echo $ARG1
fi
