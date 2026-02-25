FROM coollabsio/openclaw:latest

# Copy configuration into default locations
COPY config/openclaw.json /data/.openclaw/openclaw.json
COPY workspace/ /data/workspace/
COPY skills/ /data/workspace/skills/

# Find and patch the nginx config to remove browser upstream
# (no browser sidecar container in single-container Railway deploy)
RUN NGINX_CONF=$(find /etc/nginx -name "*.conf" -exec grep -l "upstream browser" {} \; 2>/dev/null || true) && \
    if [ -n "$NGINX_CONF" ]; then \
      sed -i '/upstream browser/,/}/d' "$NGINX_CONF" && \
      sed -i '/location.*browser/,/}/d' "$NGINX_CONF"; \
    fi

# Environment
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
ENV PORT=8080
ENV NODE_ENV=production

EXPOSE 8080
