FROM coollabsio/openclaw:latest

# Copy configuration into default locations
# The entrypoint.sh will handle startup: configure → nginx (8080) → gateway (18789)
COPY config/openclaw.json /data/.openclaw/openclaw.json
COPY workspace/ /data/workspace/
COPY skills/ /data/workspace/skills/

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080
