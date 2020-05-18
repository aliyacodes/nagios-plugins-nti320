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

sleep 60

ldapdelete -x -D cn=ldapadm,dc=nti310,dc=local -W cn="James Richter",ou=People,dc=nti310,dc=local -y /root/ldap_admin_pass
ldapdelete -x -D cn=ldapadm,dc=nti310,dc=local -W cn="Book Characters",ou=Group,dc=nti310,dc=local -y /root/ldap_admin_pass
