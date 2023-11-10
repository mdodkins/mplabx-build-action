FROM ubuntu:20.04

ARG ADDITIONAL_PACKAGES="python3"

# Install the dependencies
# See https://microchipdeveloper.com/install:mplabx-lin64
RUN dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y libc6:i386 libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 libusb-1.0-0 wget sudo make ${ADDITIONAL_PACKAGES} && \
  apt-get clean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

ARG MPLABX_VERSION=6.00
ARG MPLABX_ARG="--8bitmcu 1 --16bitmcu 0 --32bitmcu 0 --othermcu 0"
ARG INSTALL_IPE=0

# Download and install MPLAB X
RUN wget -nv -O /tmp/mplabx "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v${MPLABX_VERSION}-linux-installer.tar" &&\
  cd /tmp && \
  tar -xf mplabx && \
  rm mplabx && \
  mv "MPLABX-v${MPLABX_VERSION}-linux-installer.sh" mplabx && \
  sudo ./mplabx --nox11 -- --unattendedmodeui none --mode unattended --ipe ${INSTALL_IPE} --collectInfo 0 --installdir /opt/mplabx ${MPLABX_ARG} && \
  rm mplabx

ARG COMPILER_NAME=xc8
ARG COMPILER_VERSION=2.36

# Download and install Compiler
RUN wget -nv -O /tmp/${COMPILER_NAME} "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/${COMPILER_NAME}-v${COMPILER_VERSION}-full-install-linux-x64-installer.run" && \
  chmod +x /tmp/${COMPILER_NAME} && \
  /tmp/${COMPILER_NAME} --mode unattended --unattendedmodeui none --netservername localhost --LicenseType FreeMode --prefix "/opt/microchip/${COMPILER_NAME}/v${COMPILER_VERSION}" && \
  rm /tmp/${COMPILER_NAME}

COPY build.sh /build.sh

RUN ["chmod", "+x", "/build.sh"]

ENTRYPOINT [ "/build.sh" ]
