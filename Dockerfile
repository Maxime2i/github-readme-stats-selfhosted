FROM node:24.22.1-alpine

RUN apk add --no-cache git jq bash tini && npm install -g npm@11.7.0

# Create the working directory and set permissions
WORKDIR /repo
RUN chown nobody:nobody /repo

COPY entrypoint.sh /entrypoint.sh

# Configure NPM to use a writable cache directory (since 'nobody' home is /)
ENV NPM_CONFIG_CACHE=/tmp/.npm

# Commit figé de github-readme-stats (sinon master est récupéré à chaque démarrage)
ENV GITHUB_README_STATS_REF=54a7985aeefda00d5eadb55b80c17c7f976c37d2

# Switch to non-root user
USER nobody

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/entrypoint.sh"]
