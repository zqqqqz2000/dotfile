#!/usr/bin/bash

# check if ~/.task/git-sync/ repo exists
if [ -d ~/.task/task-git-sync/ ]; then
  # pull the latest changes
  cd ~/.task/task-git-sync/
  git pull --rebase --autostash
else
  # clone the repo
  git clone git@github.com:zqqqqz2000/task-git-sync.git ~/.task/task-git-sync/
fi

# import all synced tasks to task first if exists all.json
if [ -f ~/.task/task-git-sync/all.json ]; then
  task import ~/.task/task-git-sync/all.json
fi
