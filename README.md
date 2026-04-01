# Mastodon Extended

This repository provides a custom-tailored Docker image of **Mastodon** with an increased character limit. Instead of the default 500 characters, this version allows up to **3,000 characters** per status update.

## Features
- **Extended Limit:** 3,000 characters for posts.
- **Auto-Update:** A GitHub Action checks daily for new official Mastodon releases and rebuilds the image automatically if an update is found.
- **Reliable Base:** Built directly on top of official `tootsuite/mastodon` images to ensure maximum compatibility and stability.

## How to Use (Docker / Podman)

To use this extended version, update your `docker-compose.yml` to point to this container registry instead of the official one:

```yaml
services:
  web:
    image: ghcr.io/komplix/mastodon-extended:latest
    # ... keep the rest of your configuration as is
  
  sidekiq:
    image: ghcr.io/komplix/mastodon-extended:latest
    # ...
    
  streaming:
    image: ghcr.io/komplix/mastodon-extended:latest
    # ...
```
## Manual Pull
```docker pull ghcr.io/komplix/mastodon-extended:latest```

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
