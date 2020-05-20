
#!/bin/bash
# on Nagios server 10.128.0.3
# https://raw.githubusercontent.com/Eli-Brown/NTI-320-Atom-Smasher/master/nrpe-http-eli/check_http
# https://github.com/Eli-Brown/NTI-320-Atom-Smasher/blob/master/nrpe-http-eli/check_http
# nrpe-http-eli/check_http

define command{
    command_name  check_http.1
    command_line  /usr/lib64/nagios/plugins/check_http.1  --url='$ARG1$' --extra_args='$ARG2$'
}

define service {
        host_name                       example
        service_description             service_name
        check_command                   check_http.1!http://10.128.0.3/path!--proxy http://user:name@host:8080 --user user:name --ntlm
        use                             generic-service
        notes                           some useful notes >>>not sure this is right
}


URL=$ARG1
KEY=$ARG2

curl -I -s -L <http://10.128.0.3> | grep "HTTP/1.1"

