FROM coollabsio/openclaw:latest

# Copy configuration into default locations
COPY config/openclaw.json /data/.openclaw/openclaw.json
COPY workspace/ /data/workspace/
COPY skills/ /data/workspace/skills/

# Remove the browser upstream from nginx config to prevent crash
# (no browser sidecar container in single-container Railway deploy)
RUN sed -i '/upstream browser/,/}/d' /etc/nginx/conf.d/openclaw.conf && \
    sed -i '/location.*browser/,/}/d' /etc/nginx/conf.d/openclaw.conf

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080
