FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        gnupg \
        apt-transport-https \
        iproute2 \
        iputils-ping \
        dnsutils \
        netcat-openbsd \
        openssh-client \
        procps \
        less \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install -g @kilocode/cli \
    && rm -rf /var/lib/apt/lists/*

ENV VSCODE_CLI_USE_FILE_KEYCHAIN=true
ENV VSCODE_CLI_DISABLE_KEYCHAIN_ENCRYPT=true

# VS Code CLI
RUN curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' \
        --output /tmp/vscode_cli.tar.gz \
    && tar -xzf /tmp/vscode_cli.tar.gz -C /usr/local/bin \
    && rm /tmp/vscode_cli.tar.gz \
    && chmod +x /usr/local/bin/code

WORKDIR /app

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]