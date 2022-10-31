#!/bin/bash

version=`cat Dockerfile | grep "ARG VERSION=" | awk -F "=" '{print $2}' | tr -d \"`
echo bulding $version
docker build -t phpipam-ngpf:$version .
