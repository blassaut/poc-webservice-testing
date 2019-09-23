FROM ubuntu:latest

# Defines argument which can be passed during build time.
ARG UID
ARG GID

USER root

RUN \

    # Create group that will be used to run the image
    groupadd -g $GID docker \
    && \

    # Create user that will be used to run the image
    useradd -d /build -m -u $UID -g $GID -s /bin/bash docker \
    && \

    # Add AdoptOpenJDK DEB repository
    apt-get update > /dev/null && \
    apt-get install -y wget gnupg2 > /dev/null && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    apt-get install -y software-properties-common && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && \

    # Install required packages
    echo "Install packages" \
    apt-get update && apt-get install -y \
       adoptopenjdk-11-hotspot \
       maven \
       git \
       unzip \
       curl \
       nodejs \
       npm \
       xvfb \
       libgtk-3-dev \
       libnotify-dev \
       libgconf-2-4 \
       libnss3 \
       libxss1 \
       libasound2 \
       > /dev/null \
    && \

    # Clean
    apt-get -y autoremove && \
    apt-get -y clean

# Set the correct user to run the image
USER docker
