# Use the official Mastodon image as the base
ARG MASTODON_VERSION=latest
FROM tootsuite/mastodon:${MASTODON_VERSION}

# Switch to root to perform file modifications
USER root

# Patch: Backend validation (Increases server-side limit to 3000 chars)
RUN sed -i 's/MAX_CHARS = 500/MAX_CHARS = 3000/g' /opt/mastodon/app/validators/status_length_validator.rb

# Patch: Frontend UI (Updates the character counter in the browser)
# RUN sed -i 's/500/3000/g' /opt/mastodon/app/javascript/mastodon/features/compose/components/compose_form.jsx

# Switch back to the standard mastodon user for security
USER mastodon


