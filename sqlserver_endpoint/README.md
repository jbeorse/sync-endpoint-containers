## Build 

To build the image run the following command inside the root directory:
`docker build -t <orgname>/sqlserver_endpoint .`

## Run 

After it finished building, to run the container you will need to be ready to set the following variables:

```
SERVER_URL=<address of your server instance> - If you are running on your local machine, this is your IP Address
SERVER_PORT=<port to access your server> - Default is 8080
SERVER_SECURE_PORT=<port to securely access your server> - Default is 8443
DB_URL=<address of the database server> - If you are connecting to your local machine, this is your IP Address
DB_NAME=<name of the database configured on your server>
DB_USERNAME=<username configured to own the database>
DB_PASSWORD=<password of database owner>
DB_SCHEMA=<database schema name>
LDAP_DOMAIN_L1=<First level of the LDAP domain (typically com)>
LDAP_DOMAIN_L2=<Second level of the LDAP domanin (something like mezuricloud)>
LDAP_USERNAME=<LDAP username>
LDAP_PASSWORD=<LDAP password>
REALM_STRING=<Realm string for instance>
GROUP_PREFIX=<Prefix for ODK groups>
CHANNEL_TYPE=<Set to secure if using SSL>
SECURE_CHANNEL_TYPE=<Set to secure if using SSL>
```

You can spin up an instance with the following command (with example values for the environment variables):
"docker run -d -p 80:8080 -e SERVER_URL="0.0.0.0" -e SERVER_PORT="80" -e SERVER_SECURE_PORT="8443" -e DB_URL="mezuri-r1.database.windows.net:1433" -e DB_NAME='odk_prod' -e DB_USERNAME="mitch_db_login@mezuricloud.com" -e DB_PASSWORD="PASSWORD" -e DB_SCHEMA="clarice_test" -e LDAP_DOMAIN_L1="com" -e LDAP_DOMAIN_L2="mezuricloud" -e LDAP_USERNAME="ldap_reader@mezuricloud.com" -e LDAP_PASSWORD="PASSWORD" -e REALM_STRING="opendatakit.org ODK Aggregate" -e GROUP_PREFIX="mitch_prod" -e CHANNEL_TYPE="ANY_CHANNEL" -e SECURE_CHANNEL_TYPE="ANY_CHANNEL"  odk/sqlserver_endpoint"

You can upgrade the aggregate version by dropping in a new ODKAggregate.war file. But be aware that the init.sh script depends on specific file paths, so please double check that you have not broken that script.

To run with https support, 
 - build a keystore containing your certificate by following instructions [here](https://www.godaddy.com/help/tomcat-generate-csrs-and-install-certificates-5239)
 - create a Docker secret containing the keystore, `docker secret create odksync-tomcat.keystore <PATH_TO_KEYSTORE>`
 - start the Docker service (with example values for the environment variables), `docker service create -p 443:8443 --secret odksync-tomcat.keystore -e SERVER_URL="0.0.0.0" -e SERVER_PORT="80" -e SERVER_SECURE_PORT="443" -e DB_URL="mezuri-r1.database.windows.net:1433" -e DB_NAME='odk_prod' -e DB_USERNAME="mitch_db_login@mezuricloud.com" -e DB_PASSWORD="PASSWORD" -e DB_SCHEMA="clarice_test" -e LDAP_DOMAIN_L1="com" -e LDAP_DOMAIN_L2="mezuricloud" -e LDAP_USERNAME="ldap_reader@mezuricloud.com" -e LDAP_PASSWORD="PASSWORD" -e REALM_STRING="opendatakit.org ODK Aggregate" -e GROUP_PREFIX="mitch_prod" -e CHANNEL_TYPE="REQUIRES_SECURE_CHANNEL" -e SECURE_CHANNEL_TYPE="REQUIRES_SECURE_CHANNEL"  odk/sqlserver_endpoint`
