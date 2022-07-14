#!/bin/bash

test -z "$DOCKER_ID_FIELD" && export DOCKER_ID_FIELD='{{.ID}}'

function list-containers() {
    docker ps $@ --format "$DOCKER_ID_FIELD"
}

function list-images() {
    docker images $@ --format '{{.ID}}'
}

function stop-containers() {
    docker stop $(list-containers -a)
}

function remove-containers() {
    stop-containers
    docker rm $(list-containers -a)
}

case "$1" in
    remove-images)
        remove-containers
        docker rmi $(list-images)
    ;;

    *)
        $@
    ;;
esac
