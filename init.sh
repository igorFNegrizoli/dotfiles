echo "Starting custom sripts setup"
# Write zsh config
mkdir -p ~/.local/bin
mkdir -p ~/.config/zsh
ln -sf "$HOME/.config/zsh/.zshenv" "$HOME/.zshenv"
chmod +x ~/.config/scripts/*
echo "Custom scripts setup done"
echo "Starting Claude Code setup"
# init submodules (only ralph at the time of this script creation)
git submodule update --init --recursive
cp -r deps/ralph/skills/. claude-runner/skills/
# create the empty file so I can save progress if a session ends but still dont have it on the dotfile repo
touch claude-runner/todo.txt
cp deps/ralph/ralph.sh claude-runner/
#symlink the config files to the actual path claude uses (clade code does not uses XDG Base Directory Specification)
mkdir -p ~/.claude/
ln -sfn ~/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn ~/.config/claude/skills ~/.claude/
ln -sfn ~/.config/claude/agents ~/.claude/
echo "Claude Code setup done"
echo 'Dont forget to setup your MCP servers'
