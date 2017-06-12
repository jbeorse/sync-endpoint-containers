#!/usr/bin/env bash
#PUBLIC_IP_ADDR="$(ifconfig "$(route -n|grep '^0.0.0.0'|awk '{print $8}')"|grep inet|head -n 1|awk '{print $2}')"
PUBLIC_IP_ADDR="mezuriserver.com"
export PUBLIC_IP_ADDR
docker run -d -p 80:80 -p 443:443 -e SERVER_URL="$PUBLIC_IP_ADDR" -e SERVER_PORT="80" -e SERVER_SECURE_PORT="443" -e DB_URL="odkdemo.database.windows.net:1433" -e DB_NAME='odkdemo' -e DB_USERNAME="XXXXX" -e DB_PASSWORD="XXXXX" -e DB_SCHEMA="XXXXX" -e LDAP_DOMAIN_L1="com" -e LDAP_DOMAIN_L2="mezuricloud2" -e LDAP_USERNAME="XXXXX" -e LDAP_PASSWORD="XXXXX" -e REALM_STRING="testingorg ODK Aggregate" -e GROUP_PREFIX="odkdemo" -e CHANNEL_TYPE="ANY_CHANNEL" -e SECURE_CHANNEL_TYPE="ANY_CHANNEL" mezuri/sqlserver_endpoint
