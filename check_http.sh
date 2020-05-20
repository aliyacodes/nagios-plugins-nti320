
#!/bin/bash
#Verificar um HTTPS
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
CRIT=$3
http_proxy=""



TC=`echo ${URL} | awk -F. '{print $1}' |awk -F/ '{print $NF}'`
TMP="/tmp/check_http_sh_${TC}.tmp"

CMD_TIME="curl -k --location --no-buffer --silent --output ${TMP} -w %{time_connect}:%{time_starttransfer}:%{time_total} '${URL}'"
TIME=`eval $CMD_TIME`

if [ -f $TMP ]; then
RESULT=`grep -c $URL
else
echo "UNKOWN - Could not create tmp file $TMP"
# exit 3
fi

rm -f $TMP

SURL=`echo $URL | cut -d "/" -f3-4`



echo "OK - $ARG1"
exit 0
else
echo "HTTP STATUS & ADDRESS - $ARG1"
exit 2
fi
