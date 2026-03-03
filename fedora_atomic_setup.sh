flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.mozilla.firefox org.qbittorrent.qBittorrent com.spotify.Client org.dbgate.DbGate org.videolan.vlc md.obsidian.Obsidian -y
xdg-mime default org.videolan.VLC.desktop video/mp4
rpm-ostree override remove firefox firefox-langpacks
toolbox create -y
toolbox run sudo dnf install -y htop fastfetch tmux
rpm-ostree install -y alacritty thunar qtile zsh rofi moby-engine docker-compose
