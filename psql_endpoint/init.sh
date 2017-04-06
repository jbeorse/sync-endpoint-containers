#!/bin/bash

# Set path variables
BASEPATH="/tmp"
WARPATH="$BASEPATH/ODKAggregate.war"
ROOTPATH="$BASEPATH/ODKAggregate"
SETTINGSNAME="odk-settings-latest"
SETTINGSPATH="$BASEPATH/$SETTINGSNAME"
SETTINGSJARPATH="$ROOTPATH/WEB-INF/lib/$SETTINGSNAME.jar"
SECURITYPATH="$SETTINGSPATH/security.properties"
JDBCPATH="$SETTINGSPATH/jdbc.properties"
RESULTPATH="/usr/local/tomcat/webapps/ROOT"

# Sed replacement strings for properties
## Server hostname
SERVERURL_PROP="s/security\.server\.hostname=.*/security\.server\.hostname=$SERVER_URL/g"
## Server port
SERVERPORT_PROP="s/security\.server\.port=.*/security\.server\.port=${SERVER_PORT:="8080"}/g"
## Secure server port
SERVERSECUREPORT_PROP="s/security\.server\.securePort=.*/security\.server\.securePort=${SERVER_SECURE_PORT:="8443"}/g"
## DB URL
DBURL_PROP="s/jdbc\.url=.*/jdbc\.url=jdbc:postgresql:\/\/$DB_URL\/$DB_NAME?autoDeserialize=true/g"
## Database username
DBUSERNAME_PROP="s/jdbc\.username=.*/jdbc\.username=${DB_USERNAME:="odk_user"}/g"
## Database password
DBPASSWORD_PROP="s/jdbc\.password=.*/jdbc\.password=$DB_PASSWORD/g"
## Database Schema
DBSCHEMA_PROP="s/jdbc\.schema=.*/jdbc\.schema=${DB_SCHEMA:="odk_prod"}/g"


## LDAP Domain L1
LDAP_DOMAIN_L1_PROP="s/security\.server\.ldapDomainDClevel1=.*/security\.server\.ldapDomainDClevel1=$LDAP_DOMAIN_L1/g"
## LDAP Domain L2
LDAP_DOMAIN_L2_PROP="s/security\.server\.ldapDomainDClevel2=.*/security\.server\.ldapDomainDClevel2=$LDAP_DOMAIN_L2/g"
## LDAP Query Username
LDAP_USERNAME_PROP="s/security\.server\.ldapQueryUsername=.*/security\.server\.ldapQueryUsername=$LDAP_USERNAME/g"
## LDAP Query Password
LDAP_PASSWORD_PROP="s/security\.server\.ldapQueryPassword=.*/security\.server\.ldapQueryPassword=$LDAP_PASSWORD/g"
## Group prefix
GROUP_PREFIX_PROP="s/security\.server\.groupPrefix=.*/security\.server\.groupPrefix=$GROUP_PREFIX/g"
## Channel Type
CHANNEL_TYPE_PROP="s/security\.server\.channelType=.*/security\.server\.channelType=$CHANNEL_TYPE/g"
## Secure Channel Type
SECURE_CHANNEL_TYPE_PROP="s/security\.server\.secureChannelType=.*/security\.server\.secureChannelType=$SECURE_CHANNEL_TYPE/g"
## Realm String
REALM_STRING_PROP="s/security\.server\.realm\.realmString=.*/security\.server\.realm\.realmString=$REALM_STRING/g"


# Unzip war and jar files
unzip $WARPATH -d $ROOTPATH
unzip $SETTINGSJARPATH -d $SETTINGSPATH
rm $SETTINGSJARPATH

# Update the settings with the configured values
sed -i $SERVERURL_PROP $SECURITYPATH
sed -i $SERVERPORT_PROP $SECURITYPATH
sed -i $SERVERSECUREPORT_PROP $SECURITYPATH
sed -i $LDAP_DOMAIN_L1_PROP $SECURITYPATH
sed -i $LDAP_DOMAIN_L2_PROP $SECURITYPATH
sed -i $LDAP_USERNAME_PROP $SECURITYPATH
sed -i $LDAP_PASSWORD_PROP $SECURITYPATH
sed -i $GROUP_PREFIX_PROP $SECURITYPATH
sed -i $CHANNEL_TYPE_PROP $SECURITYPATH
sed -i $SECURE_CHANNEL_TYPE_PROP $SECURITYPATH
sed -i $REALM_STRING_PROP $SECURITYPATH
sed -i $DBUSERNAME_PROP $JDBCPATH
sed -i $DBPASSWORD_PROP $JDBCPATH
sed -i $DBSCHEMA_PROP $JDBCPATH
sed -i $DBURL_PROP $JDBCPATH

# Repackage the jar and war
cd $SETTINGSPATH
zip -r $SETTINGSJARPATH *
mkdir $RESULTPATH
cp -r $ROOTPATH/* $RESULTPATH


# Start up tomcat
 /bin/bash /usr/local/tomcat/bin/catalina.sh run
