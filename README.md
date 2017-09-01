## Build 

To build the image run the following command (you could also clone the repository and build it locally):
`docker build --pull -t <orgname>/sync_endpoint https://github.com/jbeorse/sync-endpoint-containers.git`

You can modify the aggregate version by specifying your git repositiory url to the `REPO` build arg and your branch to the `REPO_BRANCH` build arg.
`docker build --build-arg REPO='https://github.com/jbeorse/experimental-sync-endpoint.git' --build-arg REPO_BRANCH='sync-endpoint' -t <orgname>/sync_endpoint https://github.com/jbeorse/sync-endpoint-containers.git`

## Development Build 

You can use `Dockerfile.dev` to build from the `target` directory instead of having Docker pull in the lastest version and building it.

`docker build --pull -t odk/sync_endpoint -f Dockerfile.dev .`

## Prerequisites

You must have installed Docker 17.06.1 or newer, and be running in [swarm mode](https://docs.docker.com/engine/swarm/).
 - To install [Docker](https://docs.docker.com/engine/installation/)
 - To create a [Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)

Windows Containers are not currently supported. To clarify, Linux based containers running on a Windows host should be fine, but Windows based containers are not supported.

## Run 

After it finished building, create `security.properties`, `jdbc.properties` and `logging.properties` to override the [default configuration](https://github.com/jbeorse/experimental-sync-endpoint/tree/sync-endpoint/src/main/resources/common). 

After creating the files, use these commands to make the files available to the container.
 - `docker secret create org.opendatakit.aggregate.security.properties PATH_TO_security.properties`
 - `docker secret create org.opendatakit.aggregate.jdbc.properties PATH_TO_jdbc.properties`
 - `docker config create org.opendatakit.aggregate.logging.properties PATH_TO_logging.properties`

 Select your preferred data persistence method with the `spring.profiles.active` environment variable. Currently supported options are `mysql`, `postgres` and `sqlserver`. Note that you must set up your own database before starting the endpoint. 

For example, you can start the container with the following command (with example values and a sqlserver database): 

`docker service create -p 80:8080 --secret org.opendatakit.aggregate.security.properties --secret org.opendatakit.aggregate.jdbc.properties --config org.opendatakit.aggregate.logging.properties --config org.opendatakit.sync.ldapcert -e spring.profiles.active='sqlserver' <orgname>/sync_endpoint`

#### LDAP

If you have an LDAP server that uses a certificate that is issued by a self-signed CA, make the public key of the CA available to the container with the following command: 

 `docker config create org.opendatakit.sync.ldapcert PATH_TO_CERT`

If you want to deploy an LDAP container, refer to this [repository](https://github.com/jbeorse/sync-endpoint-ldap).

#### HTTPS

To run with https support, 
 - build a keystore containing your certificate by following instructions [here](https://www.godaddy.com/help/tomcat-generate-csrs-and-install-certificates-5239)
 - create a Docker secret containing the keystore, `docker secret create odksync-tomcat.keystore <PATH_TO_KEYSTORE>`
 - start the Docker service (with example values for the environment variables), `docker service create -p 443:8443 --secret odksync-tomcat.keystore --secret org.opendatakit.aggregate.security.properties --secret org.opendatakit.aggregate.jdbc.properties --config org.opendatakit.aggregate.logging.properties --config org.opendatakit.sync.ldapcert -e spring.profiles.active='sqlserver' odk/sqlserver_endpoint`
