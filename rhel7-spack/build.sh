#!/bin/bash

BUILD_DATE=$(printf '%(%Y-%m-%d)T' -1)
BUILD_TAG=${BUILD_TAG:-${BUILD_DATE}}
BUILD_REPO=$(git config --get remote.origin.url)
BUILD_REPO_REF=$(git log -1 --format="%H")

# set $REGISTRY to the Docker username/registry to use, otherwise will default to $USER
REGISTRY=${REGISTRY:-$USER}
OUTPUT_IMAGE="${REGISTRY}/rhel8-spack-x86_64:${BUILD_TAG}-gcc11.2"

SPACK_REPO=https://github.com/spack/spack.git
SPACK_REPO_REF=v0.16.2

docker build \
  --build-arg BUILD_DATE="${BUILD_DATE}" \
  --build-arg BUILD_REPO="${BUILD_REPO}" \
  --build-arg BUILD_REPO_REF="${BUILD_REPO_REF}" \
  --build-arg SPACK_REPO="${SPACK_REPO}" \
  --build-arg SPACK_REPO_REF="${SPACK_REPO_REF}" \
  -t "${OUTPUT_IMAGE}" .
