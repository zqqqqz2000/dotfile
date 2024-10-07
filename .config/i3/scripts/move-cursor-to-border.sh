#!/bin/sh

direction=$1
# direction is either up, down, left, or right, check if it's valid
if [ "$direction" != "top" ] && [ "$direction" != "bottom" ] && [ "$direction" != "left" ] && [ "$direction" != "right" ]; then
  echo "Invalid direction: $direction"
  exit 1
fi

focused_window=$(xdotool getwindowfocus -f)
output=$(xdotool getwindowgeometry --shell $focused_window)
width=$(echo $output | awk '{print $4}' | cut -d "=" -f 2)
height=$(echo $output | awk '{print $5}' | cut -d "=" -f 2)
mouse_x=$(xdotool getmouselocation --shell | grep "X" | cut -d "=" -f 2)
mouse_y=$(xdotool getmouselocation --shell | grep "Y" | cut -d "=" -f 2)
window_x=$(xwininfo -id $focused_window | grep "Absolute upper-left X" | awk '{print $4}')
window_y=$(xwininfo -id $focused_window | grep "Absolute upper-left Y" | awk '{print $4}')

# check direction then move mouse
if [ "$direction" = "top" ]; then
  move_x=$mouse_x
  move_y=$((window_y + 1))
elif [ "$direction" = "bottom" ]; then
  move_x=$mouse_x
  move_y=$((window_y + height - 10))
elif [ "$direction" = "left" ]; then
  move_x=$((window_x + 1))
  move_y=$mouse_y
elif [ "$direction" = "right" ]; then
  move_x=$((window_x + width - 10))
  move_y=$mouse_y
fi

xdotool mousemove $move_x $move_y
