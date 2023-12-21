#!/bin/sh -l

PROJECT=$1
CONFIGURATION=$2
MPLABX_VERSION=$3
COMPILER_NAME=$4
COMPILER_VERSION=$5
ADDITIONAL_PACKAGES=$6
INSTALL_IPE=$7

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
    --build-arg ADDITIONAL_PACKAGES="${ADDITIONAL_PACKAGES}" \
    --build-arg INSTALL_IPE="${INSTALL_IPE}" \
    . \
    && cd .. \
    && docker run --add-host=host.docker.internal:host-gateway -v "$(pwd):/github/workspace" --workdir /github/workspace docker-action "${PROJECT}" "${CONFIGURATION}"
