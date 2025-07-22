#!/bin/bash
read content

# content is empty if the task is not synced
if [ -z "${content}" ]; then
  exit 0
fi

~/.config/task/hooks/sync-out.sh
