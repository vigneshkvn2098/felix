FROM ghcr.io/openclaw/openclaw:latest

USER root

# Create persistent data directories and set ownership to node user
RUN mkdir -p /data/.openclaw /data/workspace /data/workspace/memory /data/workspace/skills && \
    chown -R node:node /data

# Copy configuration
COPY --chown=node:node config/openclaw.json /data/.openclaw/openclaw.json

# Copy workspace files (SOUL.md, AGENTS.md, etc.)
COPY --chown=node:node workspace/ /data/workspace/

# Copy custom skills
COPY --chown=node:node skills/ /data/workspace/skills/

# Switch back to non-root user
USER node

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080

CMD ["openclaw", "gateway", "--port", "8080"]
