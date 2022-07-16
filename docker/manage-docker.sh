#!/bin/bash

CURRENT=$(pwd)
DIR=$(dirname "${BASH_SOURCE[0]}")/..
cd "$DIR"
DIR=$(pwd)
cd "$CURRENT"
test -z "$DOCKER_ID_FIELD" && export DOCKER_ID_FIELD='{{.ID}}'
test -z "$DOCKER_COMPOSE_SERVICE" && export DOCKER_COMPOSE_SERVICE=debian

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

function build() {
    docker compose build
}

function stop() {
    docker compose down
}

function get-bash-source() {
  cat "$DIR/Dockerfile" | grep ^RUN | sed 's/RUN //g'
}

case "$1" in
    remove-images)
        remove-containers
        docker rmi $(list-images)
    ;;

    shell)
        docker compose run "$DOCKER_COMPOSE_SERVICE" bash
    ;;

    up)
        build
        docker compose up -d
    ;;

    get-bash-source)
        get-bash-source
    ;;

    *)
        $@;
    ;;
esac
