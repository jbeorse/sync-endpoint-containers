## Build 

To build the image run the following command (you could also clone the repository and build it locally):
`docker build --pull -t <orgname>/sync_endpoint https://github.com/opendatakit/sync-endpoint-containers.git`

You can modify the aggregate version by specifying your git repositiory url to the `REPO` build arg and your branch to the `REPO_BRANCH` build arg.
`docker build --build-arg REPO='https://github.com/opendatakit/sync-endpoint.git' --build-arg REPO_BRANCH='master' -t <orgname>/sync_endpoint https://github.com/opendatakit/sync-endpoint-containers.git`

## Development Build 

You can use `Dockerfile.dev` to build from the `target` directory instead of having Docker pull in the lastest version and building it.

`docker build --pull -t odk/sync_endpoint -f Dockerfile.dev .`

## Prerequisites

You must have installed Docker 17.06.1 or newer, and be running in [swarm mode](https://docs.docker.com/engine/swarm/).
 - To install [Docker](https://docs.docker.com/engine/installation/)
 - To create a [Swarm](https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/)

Windows Containers are not currently supported. To clarify, Linux based containers running on a Windows host should be fine, but Windows based containers are not supported.

## Run 

Refer to [sync-endpoint-default-setup](https://github.com/opendatakit/sync-endpoint-default-setup) for configuration. `docker-compose.yml` in that repository contains a working setup of Sync Endpoint, you could use that as a reference for configuration. 
