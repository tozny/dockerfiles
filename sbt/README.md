# docker-sbt
Dockerfile for sbt (Scala build tool)

This is built on top of the
[openjdk](https://hub.docker.com/_/openjdk/) image
and takes inspiration from
[hseeberger/scala-sbt](https://github.com/hseeberger/scala-sbt).

## Usage

Install [Docker](https://www.docker.com/) and pull the image
([tozny/sbt](https://hub.docker.com/r/tozny/sbt/) on DockerHub):

    docker pull tozny/sbt

You can then run `sbt` inside docker to compile code like:

    docker run -it --rm tozny/sbt sbt shell

If you want to execute sbt commands on a project on your local
filesystem, you may want to mount the current directory and various
local caches as volumes and set the working directory as well:

    docker run -it --rm -v ~/.ivy2:/root/.ivy2 -v ~/.sbt:/root/.sbt -v $PWD:/app -w /app tozny/sbt sbt shell

## Building

To build, you need to specify the desired openjdk and sbt versions via
`--build-arg` parameters:

    docker build --build-arg OPENJDK_TAG=8u292 --build-arg SBT_VERSION=1.5.4 .

## Pushing a new tag to DockerHub

To push and tag a new image with updated versions of openjdk and sbt,
you'll need to have a DockerHub account that's a member of the appropriate
tozny organization and be logged in to DockerHub:

    docker login --username=mydockerhubusername

Then use the following recipe to build and push:

```bash
OPENJDK_TAG=8u292
SBT_VERSION=1.5.4

docker build \
    --build-arg OPENJDK_TAG=$OPENJDK_TAG \
    --build-arg SBT_VERSION=$SBT_VERSION \
    --tag tozny/sbt:${OPENJDK_TAG}_${SBT_VERSION} \
    --tag tozny/sbt:latest \
    .

docker push tozny/sbt:${OPENJDK_TAG}_${SBT_VERSION}
docker push tozny/sbt:latest
```
