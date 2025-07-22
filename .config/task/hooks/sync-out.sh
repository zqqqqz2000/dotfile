#!/usr/bin/bash

# task export to ~/.task/task-git-sync/all.json
task export >~/.task/task-git-sync/all.json

cd ~/.config/task/task-git-sync/
# if changed, add all.json to git and push
if [ -n "$(git status --porcelain)" ]; then
  git add ~/.config/task/task-git-sync/all.json
  git commit -m "sync: $(date +%Y-%m-%d) from $USER@$(hostname)"
  git push
fi
