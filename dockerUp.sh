#!/bin/bash
rm -fr postgres-data
docker-compose -f docker-compose.yml up
