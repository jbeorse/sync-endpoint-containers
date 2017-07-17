## Build 

To build the image run the following command inside the root directory:
`docker build -t <orgname>/sqlserver_endpoint .`

You can modify the aggregate version by specifying your git repositiory url to the `REPO` build arg and your branch to the `REPO_BRANCH` build arg.

## Run 

After it finished building, create `security.properties`, `jdbc.properties` and `logging.properties` to override the [default configuration](https://github.com/jbeorse/experimental-sync-endpoint/tree/sync-endpoint/src/main/resources/common). 

After creating the files, use these commands to make the files available to the container.
 - `docker secrets create org.opendatakit.aggregate.security.properties PATH_TO_security.properties`
 - `docker secrets create org.opendatakit.aggregate.jdbc.properties PATH_TO_jdbc.properties`
 - `docker config create org.opendatakit.aggregate.logging.properties PATH_TO_loggin.properties`

 Select your preferred data persistence method with the `spring.profiles.active` environment variable. Currently supported options are `mysql`, `postgres` and `sqlserver`. 

 If your LDAP server uses a self-signed CA certificate, have it available to the container with the following command: 

 `docker config create org.opendatakit.sync.ldapcert PATH_TO_CERT`

You can start the container with the following command (with example values): 

`docker service create -p 80:8080 --secret org.opendatakit.aggregate.security.properties --secret org.opendatakit.aggregate.jdbc.properties --config org.opendatakit.aggregate.logging.properties --config org.opendatakit.sync.ldapcert -e spring.profiles.active='sqlserver' odk/sqlserver_endpoint`

To run with https support, 
 - build a keystore containing your certificate by following instructions [here](https://www.godaddy.com/help/tomcat-generate-csrs-and-install-certificates-5239)
 - create a Docker secret containing the keystore, `docker secret create odksync-tomcat.keystore <PATH_TO_KEYSTORE>`
 - start the Docker service (with example values for the environment variables), `docker service create -p 443:8443 --secret odksync-tomcat.keystore --secret org.opendatakit.aggregate.security.properties --secret org.opendatakit.aggregate.jdbc.properties --config org.opendatakit.aggregate.logging.properties --config org.opendatakit.sync.ldapcert -e spring.profiles.active='sqlserver' odk/sqlserver_endpoint`
