#!/usr/bin/env bash
sed -i '11aENV PUPPETEER_SKIP_DOWNLOAD=true' Dockerfile
docker buildx build . --output type=docker,name=elestio4test/parse-dashboard:latest | docker load