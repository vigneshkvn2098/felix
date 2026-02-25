FROM coollabsio/openclaw:latest

# Copy configuration into default locations
COPY config/openclaw.json /data/.openclaw/openclaw.json
COPY workspace/ /data/workspace/
COPY skills/ /data/workspace/skills/

# Custom entrypoint: run configure then gateway directly (skip nginx)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
