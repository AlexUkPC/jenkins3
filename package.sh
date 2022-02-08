#!/bin/bash
set -e
VERSION=${1:-latest}
docker build -f Dockerfile.prod -t alexrogna/jenkins3_web:prod -t alexrogna/jenkins3_web:${VERSION} --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .