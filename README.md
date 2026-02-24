# Dotfiles

##What it manages

Run this script at first setup: `init.sh`

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


## Running claude inside a devcontainer
```
devcontainer up --workspace-folder ~/.config/claude-runner/ --remove-existing-container
docker ps
docker exec -it <devcontainer_container_id> bash
```
