# Environment: Docker container with fixed ports

Pi runs inside a Docker container. Only the following ports are exposed to the host:

- **30141** — Pi's web UI (do not use for anything else)
- **30142** — code-server (browser VS Code); do not use for anything else
- **8000** — the port for serving test pages, web previews, and local HTTP servers

## Serving test pages

- Always start local HTTP/web servers (preview pages, dev servers, static file servers) on **port 8000**, e.g. `python3 -m http.server 8000` or equivalent.
- Never bind test servers or preview servers to any other port (they would be unreachable from the host).
- Never use ports 30141 and 30142 — they are reserved for Pi's web UI and code-server (VS Code).
- If port 8000 is already in use, stop the existing process (`fuser -k 8000/tcp` or `lsof -t -i:8000 | xargs kill`) and reuse port 8000 rather than picking another port.
- When giving the user a link, use `http://localhost:8000/` (from the host's perspective the container's port 8000 is mapped directly).
