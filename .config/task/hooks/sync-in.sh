#!/usr/bin/bash

# check if ~/.task/git-sync/ repo exists
if [ -d ~/.config/task/task-git-sync/ ]; then
  # pull the latest changes
  cd ~/.config/task/task-git-sync/
  git pull --rebase --autostash
else
  # clone the repo
  git clone git@github.com:zqqqqz2000/task-git-sync.git ~/.config/task/task-git-sync/
fi

# import all synced tasks to task first if exists all.json
if [ -f ~/.config/task/task-git-sync/all.json ]; then
  task import ~/.config/task/task-git-sync/all.json
fi
