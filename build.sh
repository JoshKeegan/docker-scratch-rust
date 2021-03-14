#!/bin/bash

echo "Building image:"
docker build -t docker-scratch-rust .

echo "Image built:"
docker image ls docker-scratch-rust

echo "Running image:"
docker run --rm docker-scratch-rust