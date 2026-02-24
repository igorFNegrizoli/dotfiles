# CLAUDE.md

## Environment
You are running inside an isolated devcontainer. You have:
- Full read/write access to /workspace (the project)
- Docker CLI access via the host socket
- No SSH keys — git push is intentionally disabled
- Network access to project services via the Docker network

## Task Runner
This project uses `just`. A `justfile` exists at `/workspace/justfile`.
Run `just --list` to see available recipes before managing containers or running tasks.

## MCP Tools Available
- `dev-browser` — launch a browser to test frontend implementations
- `open-webSearch` — search the web for documentation, packages, etc.

## Important Rules
- Do NOT run `git push` (it is blocked). You are allowed to make commits though
- Do NOT modify `.env` files without confirmation
