FROM ghcr.io/openclaw/openclaw:latest

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

EXPOSE 8080

CMD ["openclaw", "gateway", "--port", "8080"]
