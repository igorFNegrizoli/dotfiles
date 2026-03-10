echo "Running the setup for Fedora Atomic 43 (Cosmic)"
sudo -v

echo "Adding Flatpaks"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser org.qbittorrent.qBittorrent com.spotify.Client org.dbgate.DbGate org.videolan.VLC md.obsidian.Obsidian -y
xdg-mime default org.videolan.VLC.desktop video/mp4
echo "Removing firefox installed by layering"
rpm-ostree override remove firefox firefox-langpacks
echo "Applying brave policies"
sudo mkdir -p /etc/brave/policies/managed/
sudo ln -sfn ~/.config/brave/policy.json /etc/brave/policies/managed/
sudo flatpak override com.brave.Browser --filesystem="/etc/brave/policies/managed:ro" --filesystem="~/.config/brave:ro"

echo "Installing layered packages via rpm-ostree"
rpm-ostree install -y zsh moby-engine docker-compose

echo "Installing Oh My Zsh..."
ZSH="$HOME/.oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
echo "Write zsh config"
sudo usermod -s $(which zsh) $USER
mkdir -p ~/.local/bin
mkdir -p ~/.config/zsh
ln -sf "$HOME/.config/zsh/.zshenv" "$HOME/.zshenv"

echo "Allowing custom scripts"
chmod +x ~/.config/scripts/*

echo "Creating toolbox and installing htop, fastfetch"
toolbox create -y
toolbox run sudo dnf install -y htop fastfetch zsh
toolbox run sudo chsh -s /usr/bin/zsh $USER
# no tmux and alacritty for now

echo "Starting Claude Code setup - No claude-runner container being set (will have its own repo)"
# init submodules (only ralph at the time of this script creation)
# git submodule update --init --recursive
# cp -r deps/ralph/skills/. claude-runner/skills/
# create the empty file so I can save progress if a session ends but still dont have it on the dotfile repo
# touch claude-runner/todo.txt
# cp deps/ralph/ralph.sh claude-runner/
#symlink the config files to the actual path claude uses (clade code does not uses XDG Base Directory Specif>
mkdir -p ~/.claude/
ln -sfn ~/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn ~/.config/claude/skills ~/.claude/
ln -sfn ~/.config/claude/agents ~/.claude/
echo "Claude Code setup done"
echo 'Dont forget to setup your MCP servers'

echo "Setting up git configs"
git config --global user.email "igor.negrizoli@gmail.com"
git config --global user.name "Igor F. Negrizoli"
git config --global url."git@github.com:".insteadOf "https://github.com/"
echo "fedora_atomic_setup.sh completed"
