FROM node:22-slim

# Install minimal toolchain required for typical lecture tasks
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Fix Git ownership checks across host/container boundaries for the 'node' user
RUN git config --system --add safe.directory "*"

# Install code-server (browser VS Code) — apt resolves its dependencies automatically
ARG CODE_SERVER_VERSION=4.145.2
RUN curl -fsSL -o /tmp/code-server.deb \
      https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb \
    && apt-get update \
    && apt-get install -y /tmp/code-server.deb \
    && rm -rf /var/lib/apt/lists/* /tmp/code-server.deb

# Install Pi Agent and Pi Web globally
RUN npm install -g @earendil-works/pi-coding-agent
RUN npm install -g @agegr/pi-web@latest
RUN pi install npm:pi-provider-litellm

# Prepare workspace and settings directory for the unprivileged 'node' user
RUN mkdir -p /workspace /home/node/.pi/agent && \
    chown -R node:node /workspace /home/node/.pi

# Switch away from root to unprivileged user
USER node
WORKDIR /workspace

EXPOSE 30141 30142

# Run code-server in the background, pi-web as the main process
CMD ["bash", "-c", "code-server --bind-addr 0.0.0.0:30142 --auth none & exec pi-web --port 30141 --no-open --hostname 0.0.0.0"]