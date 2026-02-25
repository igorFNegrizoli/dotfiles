# init submodules (only ralph at the time of this script creation)
git submodule update --init --recursive
cp -r deps/ralph/skills/. claude-runner/skills/
# create the empty file so I can save progress if a session ends but still dont have it on the dotfile repo
touch claude-runner/todo.txt
cp -R claude/skills/ ~/.claude/
cp claude/CLAUDE.md ~/.claude/
#symlink the config files to the actual path claude uses (clade code does not uses XDG Base Directory Specification)
ln -sf ~/.config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/.config/claude/skills ~/.claude/
echo 'Dont forget to setup your MCP servers'


