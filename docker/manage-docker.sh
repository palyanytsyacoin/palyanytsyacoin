#!/bin/bash

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

    *)
        $@;
    ;;
esac
