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

RUN install -d -m 0755 /etc/apt/keyrings \
    && curl -fsSL https://downloads.claude.ai/keys/claude-code.asc \
       -o /etc/apt/keyrings/claude-code.asc \
    && gpg --show-keys /etc/apt/keyrings/claude-code.asc \
    && echo "Fingerprint: 31DDDE24DDFAB679F42D7BD2BAA929FF1A7ECACE"

RUN echo "deb [signed-by=/etc/apt/keyrings/claude-code.asc] https://downloads.claude.ai/claude-code/apt/stable stable main" \
      | tee /etc/apt/sources.list.d/claude-code.list

RUN apt-get update && apt-get install -y --no-install-recommends claude-code \
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