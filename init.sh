# init submodules (only ralph at the time of this script creation)
git submodule update --init --recursive
cp -r deps/ralph/skills/. claude-runner/skills/
# create the empty file so I can save progress if a session ends but still dont have it on the dotfile repo
touch claude-runner/todo.txt
#symlink the config files to the actual path claude uses (clade code does not uses XDG Base Directory Specification)
mkdir -p ~/.claude/
ln -sfn ~/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn ~/.config/claude/skills ~/.claude/
ln -sfn ~/.config/claude/agents ~/.claude/
echo 'Dont forget to setup your MCP servers'


