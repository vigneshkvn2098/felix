FROM node:22-slim

# Install OpenClaw globally
RUN npm install -g openclaw@latest

# Install system dependencies for browser automation and media processing
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ffmpeg chromium && \
    rm -rf /var/lib/apt/lists/*

# Create persistent data directories
RUN mkdir -p /data/.openclaw /data/workspace /data/workspace/memory

# Copy configuration
COPY config/openclaw.json /data/.openclaw/openclaw.json

# Copy workspace files (SOUL.md, AGENTS.md, etc.)
COPY workspace/ /data/workspace/

# Copy custom skills
COPY skills/ /data/workspace/skills/

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

EXPOSE 8080

CMD ["openclaw", "gateway", "--port", "8080"]
