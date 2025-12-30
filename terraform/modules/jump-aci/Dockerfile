FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl apt-transport-https lsb-release gnupg openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Install Azure CLI (official Microsoft method)
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Copy your entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
