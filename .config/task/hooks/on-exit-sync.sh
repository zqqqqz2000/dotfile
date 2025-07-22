read content

# content is empty if the task is not synced
if [ -z "${content}" ]; then
  exit 0
fi

~/.task/hooks/sync-out.sh
