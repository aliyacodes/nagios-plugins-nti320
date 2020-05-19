#!/bin/bash
cd /tmp
echo -e "version: 1
# Entry 1: cn=Book Characters,ou=Group,dc=nti310,dc=local
dn: cn=Book Characters,ou=Group,dc=nti310,dc=local
cn: Book Characters
gidnumber: 500
objectclass: posixGroup
objectclass: top" > bookcharacters.ldif

echo -e "version: 1
# Entry 1: cn=James Richter,ou=People,dc=nti310,dc=local
dn: cn=James Richter,ou=People,dc=nti310,dc=local
cn: James Richter
gidnumber: 500
givenname: James
homedirectory: /home/users/jrichter
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: Richter
uid: jrichter
uidnumber: 1000
userpassword: {MD5}X03MO1qnZdYdgyfeuILPmQ==" > jamesrichter.ldif

ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f bookcharacters.ldif -y /root/ldap_admin_pass
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f jamesrichter.ldif -y /root/ldap_admin_pass

addUserOutput=$(ldapsearch -x -D cn=ldapadm,dc=nti310,dc=local -b cn="James Richter",ou=People,dc=nti310,dc=local -y /root/ldap_admin_pass | grep -c Success)

if [ $addUserOutput == "1" ]; then
        echo "ADD USER STATUS: OK"
        add_user_status="0";

  elif [ $addUserOutput == "0" ]; then
                echo "ADD USER STATUS: CRITICAL"
                add_user_status="2";
else
        echo "ADD USER STATUS: UNKNOWN"
        add_user_status="3";
fi

addGroupOutput=$(ldapsearch -x -D cn=ldapadm,dc=nti310,dc=local -b cn="Book Characters",ou=Group,dc=nti310,dc=local -y /root/ldap_admin_pass | grep -c Success)

if [ $addGroupOutput == "1" ]; then
        echo "ADD GROUP STATUS: OK"
        add_group_status="0";

  elif [ $addGroupOutput == "0" ]; then
                echo "ADD GROUP STATUS: CRITICAL"
                add_group_status="2";
else
        echo "ADD GROUP STATUS: UNKNOWN"
        add_group_status="3";
fi

if [ $add_group_status == "0" ] && [ $add_user_status == "0" ];  then
        echo "OVERALL ADD STATUS: OK"
        add_status="0";

  elif  [ $add_group_status == "2" ] || [ $add_user_status == "2" ]; then
                echo "OVERALL ADD STATUS: CRITICAL "
                echo "$add_group_status"
                echo "$add_user_status"
                add_status="2";
else
        echo "OVERALL ADD STATUS: UNKNOWN " 
        echo "$add_group_status"
        echo "$add_user_status"
        add_status="3";
fi

echo -e "\n"
sleep 5

ldapdelete -x -D cn=ldapadm,dc=nti310,dc=local -W cn="James Richter",ou=People,dc=nti310,dc=local -y /root/ldap_admin_pass
ldapdelete -x -D cn=ldapadm,dc=nti310,dc=local -W cn="Book Characters",ou=Group,dc=nti310,dc=local -y /root/ldap_admin_pass

removeUserOutput=$(ldapsearch -x -D cn=ldapadm,dc=nti310,dc=local -b cn="James Richter",ou=People,dc=nti310,dc=local -y /root/ldap_admin_pass | grep -c Success)

if [ $removeUserOutput == "0" ]; then
        echo "REMOVE USER STATUS: OK"
        remove_user_status="0";

  elif [ $removeUserOutput == "1" ]; then
                echo "REMOVE USER STATUS: CRITICAL"
                remove_user_status="2";
else
        echo "REMOVE USER STATUS: UNKNOWN"
        remove_user_status="3";
fi

removeGroupOutput=$(ldapsearch -x -D cn=ldapadm,dc=nti310,dc=local -b cn="Book Characters",ou=Group,dc=nti310,dc=local -y /root/ldap_admin_pass | grep -c Success)

if [ $removeGroupOutput == "0" ]; then
        echo "REMOVE GROUP STATUS: OK"
        remove_group_status="0";

  elif [ $removeGroupOutput == "1" ]; then
                echo "REMOVE GROUP STATUS: CRITICAL"
                remove_group_status="2";
else
        echo "REMOVE GROUP STATUS: UNKNOWN"
        remove_group_status="3";
fi

if [ $remove_group_status == "0" ] && [ $remove_user_status == "0" ];  then
        echo "OVERALL REMOVE STATUS: OK"
        remove_status="0";

  elif  [ $remove_group_status == "2" ] || [ $remove_user_status == "2" ]; then
                echo "OVERALL REMOVE STATUS: CRITICAL "
                echo "$remove_group_status"
                echo "$remove_user_status"
                remove_status="2";
else
        echo "OVERALL REMOVE STATUS: UNKNOWN " 
        echo "$remove_group_status"
        echo "$remove_user_status"
        remove_status="3";
fi

echo -e "\n"

if [ $add_status == "0" ] && [ $remove_status == "0" ];  then
        echo "OVERALL STATUS: OK";

  elif  [ $add_status == "2" ] || [ $remove_status == "2" ]; then
                echo "OVERALL STATUS: CRITICAL "
                echo "$add_status"
                echo "$remove_status";
else
        echo "OVERALL STATUS: UNKNOWN " 
        echo "$add_status"
        echo "$remove_status"
fi
