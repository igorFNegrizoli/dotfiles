# Dotfiles

## First of all

Run this script at first setup
`./init.sh`

##What it manages

alacritty
claude (running at host)
claude-runner (isolated on devcontainer)
htop
nautilus
opencode
qBittorrent
qtile
tmux

Note: With the addition of the [Ralph Loop Repo](https://github.com/snarktank/ralph) to already ship `claude-runner` with batteries included


## Installing Claude code MCPs
Well, Claude Code adds its MCP configurations on `~/.claude.json` which witholds sensitive data. Given that, I will need to manually run the MCPs at startup
`claude mcp add open-websearch -- npx -y @smithery/cli run Aas-ee/open-websearch`


## Running claude inside a devcontainer
```
devcontainer up --workspace-folder ~/.config/claude-runner/ --remove-existing-container
docker ps
docker exec -it <devcontainer_container_id> bash
```
