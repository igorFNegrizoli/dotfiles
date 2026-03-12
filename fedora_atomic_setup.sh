echo "Running the setup for Fedora Atomic 43 (Cosmic)"
sudo -v

OSTREE_PACKAGES="zsh moby-engine docker-compose distrobox"
OSTREE_INSTALLED=true

for pkg in $OSTREE_PACKAGES; do
    if ! rpm -q "$pkg" &>/dev/null; then
        OSTREE_INSTALLED=false
        break
    fi
done

if [ "$OSTREE_INSTALLED" = false ]; then
    echo "Installing layered packages via rpm-ostree"
    rpm-ostree install -y zsh moby-engine docker-compose distrobox
    echo "Removing pre-installed layered firefox"
    rpm-ostree override remove firefox firefox-langpacks
    echo "rpm-ostree changes staged. Rebooting in 5 seconds..."
    echo "Re-run this script after reboot to complete setup."
    sleep 5
    systemctl reboot
    exit 0
else
    echo "rpm-ostree packages already installed, skipping reboot step."
fi

echo "Adding Flatpaks"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser org.qbittorrent.qBittorrent com.spotify.Client org.dbgate.DbGate org.videolan.VLC md.obsidian.Obsidian -y
xdg-mime default org.videolan.VLC.desktop video/mp4
echo "Applying brave policies"
sudo mkdir -p /etc/brave/policies/managed/
sudo ln -sfn ~/.config/brave/policy.json /etc/brave/policies/managed/
sudo flatpak override com.brave.Browser --filesystem="/etc/brave/policies/managed:ro" --filesystem="~/.config/brave:ro"

echo "Installing Oh My Zsh..."
ZSH="$HOME/.oh-my-zsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
echo "Write zsh config"
sudo usermod -s $(which zsh) $USER
mkdir -p ~/.local/bin
mkdir -p ~/.config/zsh
ln -sf "$HOME/.config/zsh/.zshenv" "$HOME/.zshenv"

echo "Allowing custom scripts"
chmod +x ~/.config/scripts/*

echo "Setting up Distrobox environment with VSCode"
distrobox-create --name ubuntu-lts --image ubuntu:24.04 --yes
distrobox-enter -n ubuntu-lts -- sudo apt update -y
distrobox-enter -n ubuntu-lts -- sudo apt upgrade -y
distrobox-enter -n ubuntu-lts -- sudo apt install -y git wget curl gpg
distrobox-enter -n ubuntu-lts -- wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
distrobox-enter -n ubuntu-lts -- sudo apt install ./vscode.deb -y
# distrobox-enter -n ubuntu-lts -- rm vscode.deb
distrobox-enter -n ubuntu-lts -- distrobox-export --app code

echo "Creating toolbox and installing htop, fastfetch"
toolbox create -y
toolbox run sudo dnf install -y htop fastfetch zsh v4l-utils
toolbox run sudo chsh -s /usr/bin/zsh $USER

# Docker out of Podman workaround for igorfnegrizoli/grounded-ralph
systemctl --user enable --now podman.socket

echo "Starting Claude Code setup"
# Claude config setup
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
