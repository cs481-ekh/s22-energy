#!/bin/bash

# remove the old database nonsense
rm -fr postgres-data

# build the docker containers
docker build -t frontend_and_backend .

# bring the docker containers to life
docker-compose -f docker-compose.yml up
