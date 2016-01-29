#!/bin/bash
version=$(grep "version=" Dockerfile|sed -e "s/^[^\"]\+\"//"|sed -e "s/\".*//")
docker build -t runjak/docker-signal:$version .
