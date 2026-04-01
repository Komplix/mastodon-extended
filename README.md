[![Auto-Update Mastodon Extended](https://github.com/Komplix/mastodon-extended/actions/workflows/auto-update.yml/badge.svg)](https://github.com/Komplix/mastodon-extended/actions/workflows/auto-update.yml)

# Mastodon Extended

This repository provides a custom-tailored Docker image of **Mastodon** with an increased character limit. Instead of the default 500 characters, this version allows up to **3,000 characters** per status update.

## Features
- **Extended Limit:** 3,000 characters for posts.
- **Auto-Update:** A GitHub Action checks daily for new official Mastodon releases and rebuilds the image automatically if an update is found.
- **Reliable Base:** Built directly on top of official `tootsuite/mastodon` images to ensure maximum compatibility and stability.

## How to Use (Docker / Podman)

To enable extended character limits, update your `docker-compose.yml` etc. by replacing the official image with this custom build.

### Update Image Tags
Replace all occurrences of the main image (example for version `v4.5.8`):

**From:**
`docker.io/tootsuite/mastodon:v4.5.8`

**To:**
`ghcr.io/komplix/mastodon-extended:v4.5.8`

### Important: Keep Streaming Image
**Do not change** the streaming image. It should remain the official one, as it does not require the character limit patch:
`docker.io/tootsuite/mastodon-streaming:v4.5.8`

### Reverting Changes
If you encounter any issues, you can switch back to the official image at any time.
*   **Existing posts** with up to 3,000 characters will remain intact and visible.
*   **New posts** will simply be restricted to the default 500-character limit again.

## Manual Pull
```docker pull ghcr.io/komplix/mastodon-extended:v4.5.8```

## Technical Implementation
The build process patches the validation logic during the Docker build stage using a sed command:
- Target File: /opt/mastodon/app/validators/status_length_validator.rb
- Modification: Replaces MAX_CHARS = 500 with MAX_CHARS = 3000.

## Important Note
This image patches the Server-Side Validation.
- Federation: Your server will successfully accept and federate 3,000 characters.
- Frontend: The web interface (browser) may still show a countdown starting at 500 or turn red after 500 characters. This is a visual-only limitation; your posts will still be saved and published correctly up to the 3,000-character limit.
 
## License
This project follows the licensing of the original Mastodon project.
