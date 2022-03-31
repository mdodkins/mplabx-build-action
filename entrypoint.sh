#!/bin/sh -l

MPLABX_VERSION=$1
COMPILER_NAME=$2
COMPILER_VERSION=$3
PROJECT=$4
CONFIGURATION=$5

MPLABX_ARG="--8bitmcu "
if [[ "$COMPILER_VERSION" == *"8"* ]]; then
  MPLABX_ARG="${MPLABX_ARG} 1"
else
  MPLABX_ARG="${MPLABX_ARG} 0"
fi

MPLABX_ARG="${MPLABX_ARG} --16bitmcu "
if [[ "$COMPILER_VERSION" == *"16"* ]]; then
  MPLABX_ARG="${MPLABX_ARG} 1"
else
  MPLABX_ARG="${MPLABX_ARG} 0"
fi

MPLABX_ARG="${MPLABX_ARG} --32bitmcu "
if [[ "$COMPILER_VERSION" == *"32"* ]]; then
  MPLABX_ARG="${MPLABX_ARG} 1"
else
  MPLABX_ARG="${MPLABX_ARG} 0"
fi

MPLABX_ARG="${MPLABX_ARG} --othermcu 0"

cd /docker-action
echo "Creating a docker image with MPLAB X version ${MPLABX_VERSION} and ${COMPILER_NAME} version ${COMPILER_VERSION}"

# Here we can make the construction of the image as customizable as we need
# and if we need parameterizable values it is a matter of sending them as inputs
docker build \
    -t docker-action \
    --build-arg MPLABX_VERSION="${MPLABX_VERSION}" \
    --build-arg COMPILER_NAME="${COMPILER_NAME}" \
    --build-arg COMPILER_VERSION="${COMPILER_VERSION}" \
    --build-arg MPLABX_ARG="${MPLABX_ARG}" \
    . \
    && cd .. \
    && docker run -v "$(pwd):/github/workspace" --workdir /github/workspace docker-action "${PROJECT}" "${CONFIGURATION}"
