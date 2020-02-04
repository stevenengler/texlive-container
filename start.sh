#!/usr/bin/env bash

NAME="texlive-$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 6)"
sudo docker run -i --rm --name "${NAME}" -v "$(pwd)":/host-volume --net=none --user "$(id -u):$(id -g)" texlive-container "$@"
