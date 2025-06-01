#!/bin/bash

# watch xclip -o, on change, run xclip -o | wl-copy

# 初始化上一次的剪贴板内容
previous=""

echo "开始监控 X11 剪贴板并同步到 Wayland..."

while true; do
    # 获取当前剪贴板内容
    current=$(xclip -o -selection clipboard 2>/dev/null)
    
    # 检查剪贴板内容是否发生变化
    if [ "$current" != "$previous" ] && [ -n "$current" ]; then
        echo -n "$current" | wl-copy
        previous="$current"
    fi
    
    # 短暂休眠以避免过度占用 CPU
    sleep 0.1
done
