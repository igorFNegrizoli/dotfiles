# ~/claude-runner/Dockerfile
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install Claude Code
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @anthropic-ai/claude-code

# Install Python LSP + tools
RUN apt-get install -y python3 python3-pip python3-venv && \
    pip3 install pylsp python-lsp-server[all] pyright --break-system-packages

# Install Node LSP tools
RUN npm install -g typescript typescript-language-server eslint prettier

# Install just (task runner)
RUN curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to /usr/local/bin

# Install docker CLI (to manage project containers from inside)
RUN apt-get install -y docker.io

# No git credential helpers — isolate from host
RUN git config --system --unset-all credential.helper || true
RUN git config --system core.sshCommand "echo 'You are executing in a devcontainer, I chose to disable SSH so you can not push, only commit' && exit 1"

# Also block pushes via HTTPS
RUN git config --system alias.push '!echo "'You are executing in a devcontainer, I chose to disable SSH so you can not push, only commit" && exit 1'

# Define você como o autor real
RUN git config --system user.name "Igor F. Negrizoli"
RUN git config --system user.email "igor.negrizoli@gmail.com"


WORKDIR /workspace
